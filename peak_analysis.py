import numpy as np
from scipy.ndimage import label, find_objects, maximum_filter
from scipy.optimize import curve_fit
import matplotlib.pyplot as plt
import math
#import cv2
import os
import json


def gaussian_2d(xy, x0, y0, A, sigma_x, sigma_y, offset):
    """二维高斯函数"""
    x, y = xy
    exp_part = np.exp(-(((x - x0) ** 2) / (2 * sigma_x ** 2) + ((y - y0) ** 2) / (2 * sigma_y ** 2)))
    return A * exp_part + offset


def process_matrix(inputmatrix, adaptive_block_size=13, adaptive_C=-2, min_area=3, window_size=7):
    """
    主处理函数
    :param matrix_path: 矩阵
    :param adaptive_block_size: 自适应阈值块大小
    :param adaptive_C: 自适应阈值C值
    :param min_area: 最小有效区域面积
    :param window_size: 拟合窗口大小
    :return: (原始矩阵, 处理结果列表)
    """
    # 加载并预处理矩阵
    image = inputmatrix
    matrix = image.copy()

    # 归一化处理
    normalized_image = 255 * (image - np.min(image)) / (np.max(image) - np.min(image))
    normalized_image = normalized_image.astype(np.uint8)

    # 自适应阈值处理
    thresh_image = cv2.adaptiveThreshold(
        normalized_image, 255, cv2.ADAPTIVE_THRESH_MEAN_C,
        cv2.THRESH_BINARY, adaptive_block_size, adaptive_C
    )

    # 检测连通区域
    binary_matrix = thresh_image > 15
    labeled_array, num_features = label(binary_matrix, structure=np.ones((3, 3)))
    regions = find_objects(labeled_array)

    # 过滤小区域
    filtered_regions = []
    for i, region in enumerate(regions):
        area = np.sum(labeled_array[region] == (i + 1))
        if area > min_area:
            filtered_regions.append((i + 1, region))

    # 高斯拟合分析
    results = []
    for label_id, region in filtered_regions:
        sub_matrix = matrix[region]
        labeled_sub_matrix = (labeled_array[region] == label_id)

        # 寻找局部最大值
        local_max = maximum_filter(sub_matrix, size=3) == sub_matrix
        bright_points = np.argwhere(local_max & labeled_sub_matrix)

        if len(bright_points) > 0:
            brightest_point = max(bright_points, key=lambda p: sub_matrix[tuple(p)])
            bright_points = [brightest_point]

        for point in bright_points:
            y0, x0 = point
            y_abs = region[0].start + y0
            x_abs = region[1].start + x0

            # 提取窗口数据
            y_min = max(0, y_abs - window_size)
            y_max = min(matrix.shape[0], y_abs + window_size + 1)
            x_min = max(0, x_abs - window_size)
            x_max = min(matrix.shape[1], x_abs + window_size + 1)
            window = matrix[y_min:y_max, x_min:x_max]

            # 高斯拟合
            try:
                x_indices, y_indices = np.indices(window.shape)
                initial_guess = (window_size, window_size, np.max(window), 3, 3, np.min(window))
                popt, _ = curve_fit(gaussian_2d, (x_indices.ravel(), y_indices.ravel()), window.ravel(),
                                    p0=initial_guess)

                _, _, A, sigma_x, sigma_y, _ = popt
                fwhm_x = 2.355 * sigma_x
                fwhm_y = 2.355 * sigma_y
                results.append({
                    'position': (x_abs, y_abs),
                    'fwhm': (fwhm_x, fwhm_y),
                    'intensity': A,
                    'area': np.sum(labeled_sub_matrix)
                })
            except RuntimeError:
                continue

    results_sorted = sorted(results, key= lambda x:x['intensity'],reverse=True)
    top_10_brightest_points = results_sorted[:10]


    return matrix, top_10_brightest_points



def get_top_x_percent_elements(array, x):
    """
    获取一维数组中，大小位于排序后 x% 的元素。

    参数：
        array (numpy.ndarray): 输入的一维数组。
        x (float): 百分比（0-100），表示需要获取的最大值占比。

    返回：
        numpy.ndarray: 包含排序后 x% 的元素的数组。
    """
    if not isinstance(array, np.ndarray):
        raise ValueError("input nust be a numpy array")

    if array.ndim != 1:
        raise ValueError("input nust be a 1D array")

    if not (0 <= x <= 100):
        raise ValueError("x must between 0 and 100")

    # 计算阈值点
    threshold = np.percentile(array, 100 - x)  # 因为我们需要 top x%

    return threshold


def process_matrix_universalthresh(matrix, peaknumber):
    #this is the function to analyze the matrix and return to a list with bright spots and positions
    threshold = get_top_x_percent_elements(matrix.flatten(), 5)
    print(f"Threshold: {threshold}")

    # Binary mask for thresholding
    binary_matrix = matrix > threshold
    labeled_array, num_features = label(binary_matrix, structure=np.ones((3, 3)))
    regions = find_objects(labeled_array)

    # Find bright spots
    results = []
    for i, region in enumerate(regions):
        sub_matrix = matrix[region]


        labeled_sub_matrix = (labeled_array[region] == (i + 1))

        # Find local maxima
        local_max = maximum_filter(sub_matrix, size=3) == sub_matrix
        bright_points = np.argwhere(local_max & labeled_sub_matrix) #Return the coordinates of these points, which is local maximum and in the labelled sub matrix region

        for point in bright_points:
            y0, x0 = point
            y_abs = region[0].start + y0
            x_abs = region[1].start + x0
            intensity = matrix[y_abs, x_abs]
            results.append({'position': (x_abs, y_abs), 'intensity': intensity})

    # Sort results by intensity
    results_sorted = sorted(results, key=lambda x: x['intensity'], reverse=True)
    top_N_brightest_points = results_sorted[:peaknumber]
    print(type(top_N_brightest_points))
    print(top_N_brightest_points)
    positions = [d['position'] for d in top_N_brightest_points]
    print(positions)


    return matrix, top_N_brightest_points


def visualize_results(matrix, results):
    """可视化结果"""
    fig, axs = plt.subplots(1, 2, figsize=(11, 5))

    # 原始矩阵
    ax1 = axs[0]
    im1 = ax1.imshow(matrix, cmap='hot', interpolation='nearest')
    fig.colorbar(im1, ax=ax1)
    ax1.set_title("Original Matrix")
    ax1.text(-0.1, 1.1, 'a)', transform=ax1.transAxes, fontsize=12, fontweight='bold', va='top', ha='right')

    # 标注结果
    ax2 = axs[1]
    im2 = ax2.imshow(matrix, cmap='hot', interpolation='nearest')
    fig.colorbar(im2, ax=ax2)
    ax2.set_title("Bright Spots")
    ax2.text(-0.1, 1.1, 'b)', transform=ax2.transAxes, fontsize=12, fontweight='bold', va='top', ha='right')

    # 绘制标注
    for res in results:
        x, y = res['position']
        ax2.plot(x, y, 'b.', markersize=5)
        ax2.text(x, y, f"{res['intensity']:.0f}", color="white", fontsize=8)

    plt.tight_layout()
    plt.show()

def process_universalthresh_save(filenamewithjson, matrix, peaknumber):
    originalmatrix, top_N_brightest_points = process_matrix_universalthresh(matrix,peaknumber)
    #now the returned file is a dictionary
    coords = [
        [int(item["position"][0]), int(item["position"][1])]
        for item in top_N_brightest_points
    ]
    def save_positions(filepath, coords):
        # Load existing file if it exists
        if os.path.exists(filepath):
            try:
                with open(filepath, "r") as f:
                    data = json.load(f)
            except json.JSONDecodeError:
                data = {}  # corrupted → start fresh
        else:
            data = {}

        # Replace (or add) the key
        data["positions"] = coords

        # Save result
        with open(filepath, "w") as f:
            json.dump(data, f, indent=4)

        print("Saved/updated positions in", filepath)

    save_positions(filepath=filenamewithjson,coords=coords)
