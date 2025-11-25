import numpy as np
import scipy
from scipy.optimize import curve_fit
from scipy.ndimage import convolve
import matplotlib.gridspec as gridspec
import matplotlib.pyplot as plt
#import cv2

def find_peak(matrix, sigma = 5, method="maximum_gauss", show_map = False):
    """
        Finds the peak of the matrix elements using methods "fitting", "fitting_no_filter", "maximum_gauss" and "maximum_fourier
    """

    bandwidth = 30 / sigma # Approximate value that gives gauss filter and fourier filter same bandwidth

    gauss_filtered_image = gauss_filter(matrix, sigma)
    fourier_filtered_image = fourier_filter(matrix, bandwidth)

    if show_map:
        plot_heatmaps([matrix, gauss_filtered_image, fourier_filtered_image],
                      titles =["Calibration scan data", f"Gauss filtered image, sigma={sigma}", f"Fourier filtered image, cutoff f={bandwidth}"],
                      figsize=(5,5),
                      save_fig = False)

    if method == "fitting_no_filter":
        return fit_gaussian(matrix)
    elif method == "fitting":
        return fit_gaussian(gauss_filtered_image)
    elif method == "maximum_gauss":
        return find_max(gauss_filtered_image)
    elif method == "maximum_fourier":
        return find_max(fourier_filtered_image)


def fit_gaussian(matrix):
    """
    Function that fits a 2d Gaussian function to the input matrix and returns the peak (x,y) of the
    function.
    """
    
    # Function for fitting
    def gaussian_2d(X, A, x0, y0, sigma, offset):
        x, y = X
        return A * np.exp(-((x - x0) ** 2 + (y - y0) ** 2) / (2 * sigma**2)) + offset

    # Create arrays for fitting
    x = np.array(range(matrix.shape[0]))
    y = np.array(range(matrix.shape[1]))

    X, Y = np.meshgrid(x,y)
    x_data = X.ravel()
    y_data = Y.ravel()
    z_data = matrix.ravel()

    # Initial guess
    mode = scipy.stats.mode(matrix.flatten())[0][0]
    top = np.mean(np.sort(matrix.flatten())[-5:])

    A_guess = top - mode
    offset_guess = mode

    # Estimate sigma
    matrix_row_sum = matrix.sum(axis=0)
    matrix_row_sum = matrix_row_sum - np.mean(matrix_row_sum)
    matrix_row_sum[matrix_row_sum < 0] = 0

    mean = np.sum(x * matrix_row_sum) / np.sum(matrix_row_sum)
    variance = np.sum(matrix_row_sum * (x - mean) ** 2) / np.sum(matrix_row_sum)
    sigma_guess = np.sqrt(variance)

    #p0 = [A, x0, y0, sigma, offset]
    p0 = [A_guess, matrix.shape[0]//2, matrix.shape[1]//2, sigma_guess, offset_guess]
    
    # Fit curve to data
    popt, _ = curve_fit(gaussian_2d, (x_data, y_data), z_data, p0=p0)

    # Return peak of gaussian
    return (int(round(popt[1])), int(round(popt[2])))

def find_max(matrix):
    """Find the position of the greastest value"""

    max_index = np.unravel_index(np.argmax(matrix), matrix.shape)
    return max_index[::-1]


def gaussian_kernel(size: int, sigma: float) -> np.ndarray:
    """
    Generates a (size x size) Gaussian kernel with standard deviation sigma.
    
    Parameters:
    size (int): The size of the kernel (must be an odd number).
    sigma (float): The standard deviation of the Gaussian distribution.
    
    Returns:
    np.ndarray: The Gaussian kernel as a 2D NumPy array.
    """
    assert size % 2 == 1, "Size must be an odd number"
    
    # Create coordinate grid
    k = size // 2  # Kernel half-size
    x, y = np.meshgrid(np.arange(-k, k+1), np.arange(-k, k+1))
    
    # Compute Gaussian function
    kernel = np.exp(-(x**2 + y**2) / (2 * sigma**2))
    
    # Normalize so that the sum of all elements is 1
    kernel /= kernel.sum()
    
    return kernel


def gauss_filter(matrix, sigma):

    size = max(3, 2 * int(np.ceil(3 * sigma)) + 1)

    x = cv2.getGaussianKernel(size,sigma)
    kernel = x*x.T

    kernel = kernel.astype(float)
    matrix = matrix.astype(float)

    return convolve(matrix, kernel)


def fourier_filter(matrix, freq):

    f = np.fft.fft2(matrix)
    fshift = np.fft.fftshift(f)

    rows, cols = fshift.shape
    crow,ccol = rows//2 , cols//2
    
    for x in range(cols):
        xx = x - ccol
        for y in range(rows):
            yy = y - crow
            if np.abs(xx) > freq or np.abs(yy) > freq:
                fshift[x,y] = 1

    f_ishift = np.fft.ifftshift(fshift)
    img_back = np.fft.ifft2(f_ishift)
    img_back = np.abs(img_back)

    return img_back


def frequency_spectrum(matrix):
    
    f = np.fft.fft2(matrix)
    fshift = np.fft.fftshift(f)
    magnitude_spectrum = 20*np.log(np.abs(fshift))

    return magnitude_spectrum


def plot_heatmaps(matrices, titles=None, cmap="viridis", figsize=(10, 10), save_fig = False):
    """
    Plots a list of matrices as heatmaps in a well-organized layout using matplotlib.
    
    Parameters:
    - matrices: list of np.ndarray, each representing a matrix.
    - titles: list of str, optional, titles for each heatmap.
    - cmap: str, colormap for the heatmaps.
    - figsize: tuple, figure size.
    - save_fig> bool, saves figure to "filtered_image.png" if true.
    """
    plt.close('all')
    num_matrices = len(matrices)
    cols = int(np.ceil(np.sqrt(num_matrices)))  # Determine the number of columns
    rows = int(np.ceil(num_matrices / cols))    # Determine the number of rows
    
    fig, axes = plt.subplots(rows, cols, figsize=figsize)
    axes = np.array(axes).reshape(-1)  # Flatten in case of multi-row layout
    
    for i, matrix in enumerate(matrices):
        im = axes[i].imshow(matrix, cmap=cmap, origin="lower")
        fig.colorbar(im, ax=axes[i])
        if titles and i < len(titles):
            axes[i].set_title(titles[i])
        axes[i].axis("on")
    
    # Hide any unused subplots
    for j in range(i + 1, len(axes)):
        axes[j].axis("off")
    
    plt.tight_layout()
    if save_fig:
        plt.savefig("filtered_image.png")
    plt.show(block=False)


def open_data_file(filename):
    with open(filename, "r") as file:
        data = [[int(num) for num in line.strip().split()] for line in file]
    data = np.array(data)
    return data



if __name__ == "__main__":

    # Testing code that performs analysis on nonspeedmatrix.

    filename = "nonspeedmatrix.txt"
    
    data = open_data_file(filename)
    '''
    # Uncomment this block if you want to test the find_peak function
    size_param = 1
    sigma = 3 / 5 * size_param * 25 / 5  # Adapt sigma to the size of the scan, preset scan_size=5, scan_resolution=25
    find_peak(data, sigma=sigma, show_map=True)
    exit()
    '''
    spectrum = frequency_spectrum(data)

    cutoff_frequency = 6
    fourier = fourier_filter(data, cutoff_frequency)

    sigma = 3
    gauss = gauss_filter(data, sigma)


    gauss_spectrum = frequency_spectrum(gauss)
    filtered_fourier = frequency_spectrum(fourier)

    fourier_max = find_max(fourier)
    gauss_max = find_max(gauss)

    print(f"Maximum pixel with fourier filter: {fourier_max}\nMaximum pixel with gauss filter: {gauss_max} ")

    plot_heatmaps([data, gauss, fourier, spectrum, gauss_spectrum, filtered_fourier],
                  titles = ["Data",
                            f"Gauss filtered image with sigma={sigma}",
                            f"Fourier filtered image with cutoff f={cutoff_frequency}",
                            "Frequency spectrum of data",
                            "Fourier transform of Gauss filtered image",
                            f"Frequency spectrum of data after filter with cutoff f={cutoff_frequency}"],
                  figsize = (20, 10))
