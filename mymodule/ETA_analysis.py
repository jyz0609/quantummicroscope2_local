# make the right import!
import os.path
import time
import numpy as np

from matplotlib import pyplot as plt
import traceback
import etabackend.eta as eta  # Available at: https://github.com/timetag/ETA, https://eta.readthedocs.io/en/latest/
import etabackend.tk as etatk
import json

def load_eta(recipe, **kwargs):
    print('Loading ETA')
    with open(recipe, 'r') as filehandle:
        recipe_obj = json.load(filehandle)

    eta_engine = eta.ETA()
    eta_engine.load_recipe(recipe_obj)

    # Set parameters in the recipe
    for arg in kwargs:
        eta_engine.recipe.set_parameter(arg, str(kwargs[arg]))

    eta_engine.load_recipe()

    return eta_engine
def eta_analysis(filepath, eta_engine):
    print('Starting ETA analysis')
    cut = eta_engine.clips(filepath, format=1)
    # "cut" is a generator that yields a Clip each time it is called.
    # This ensures that when running the engine, the system processes
    # only a manageable amount of data at a time.
    result = eta_engine.run({"timetagger1": cut}, group='quTAG')
    print('Finished ETA analysis')

    return result

def second_correlation(timetag_file, eta_engine, bins=50, binsize=200,measuringtime =1): #binsize is in picosecond
    # ETA analys
    result = eta_analysis(timetag_file, eta_engine)
    #result is a python dictionary, in include the variables set in the recipe

    # extract result
    hist1 = result["h3"]
    hist2 = result["h4"]
    hist0 = result["h4_zero"]
    g2_onedirection = hist1 + hist2
    hist1[0] += hist0[0]
    coin = np.concatenate((hist2[::-1], hist1))

    # To construct a bidirectional histogram, reverse one of the "start-stop" histograms.

    i3=result ["i3"]
    i4 = result["i4"]
    #get the total counts in each channel

    delta_t = np.arange(-bins, bins) * binsize * 1e-3
    #the time correspond to each bin
    print(f"size of his1 is {hist1.shape}")
    print(f"size of his2 is {hist2.shape}")
    print(f"cion at binsize {binsize} is: {coin}")
    normalize_coefficient = (int(i3) * int(i4) * binsize * (1e-12) / measuringtime)
    normalized_g2 = (hist1+hist2)/(2*normalize_coefficient)
    g2_onedirection = g2_onedirection / (2*normalize_coefficient)

    return coin,normalized_g2, delta_t,i3,i4,g2_onedirection

def analyze_savepng_returnonedirection(timetag_file, eta_engine,measuringtime, bins=100, binsize=200):
    coin, g2, delta_t, i3, i4, g2_onedirection = second_correlation(timetag_file, eta_engine, bins, binsize,measuringtime)
    try:
        timetag_folder = os.path.dirname(timetag_file)
        print(f"analyze, folder = {timetag_folder}")
    except Exception as e:
        print("Error while processing timetag_file:")
        traceback.print_exc()

    # Define output file name
    filename_txt = os.path.splitext(timetag_file)[0] + ".txt"

    # save the data in a txt file. Open the file manually to write labeled rows
    with open(filename_txt, "w") as f:
        f.write("delta_t\tcount\tnormalized_g2\n")  # Write header (tab-separated)
        for i in range(len(coin)):
            f.write(f"{delta_t[i]:.6f}\t{coin[i]:.6f}\t{g2[i]:.6f}\n")  # Tab-separated values

    print(f"Data saved successfully to {filename_txt} (compatible with Excel & Origin).")
    # distance = time_to_dist(delay)
    distance = 0
    # Define filename
    figure_save_path = os.path.splitext(timetag_file)[0] + ".png"
    # Plot the results
    fig1, [ax1, ax2] = plt.subplots(2, sharex=True)
    ax2.plot(delta_t, g2)
    ax2.legend()

    ax1.plot(delta_t, coin)

    #ax1.set_title(f"Optical delay: {int(distance)} [km]")
    ax1.set_xlabel('Time [ns]', fontsize=18)
    ax1.set_ylabel('Coincidences', fontsize=20)
    ax1.grid()

    ax2.set_xlabel('Time [ns]', fontsize=18)
    ax2.set_ylabel('$g^2$', fontsize=20)
    ax2.grid()

    # Save figure
    plt.savefig(figure_save_path, dpi=600, bbox_inches="tight")
    print(f"file saved! path = {figure_save_path}")
    #plt.show()

    return g2_onedirection