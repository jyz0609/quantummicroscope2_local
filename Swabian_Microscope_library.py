# Packages for 3D animation/gif
from __future__ import division
from matplotlib import cm
from mpl_toolkits.mplot3d import Axes3D
import mpl_toolkits.mplot3d.axes3d as p3
import matplotlib.animation as animation

# Packages for 2D gif
from PIL import Image, ImageDraw

# Packages for plotting
from matplotlib import pyplot as plt

# Packages for analysis and computation
import os
from pathlib import Path
import numpy as np

# Packages for ETA backend
import json
import etabackend.eta   # Available at: https://github.com/timetag/ETA, https://eta.readthedocs.io/en/latest/
import time
import re

import peak_analysis
import filename_process

import math
"""
FLIPPING AXIS:
np.flip(matrix, axis={...})

axis=None --> flips diagonally (transpose?)
axis=0 --> flips around x axis (up-down)
axis=1 --> flips around y axis (left-right)
"""


# Fun fact: line we scan is approx 150 micrometers wide

# ----------- FILE HANDLING --------------
def get_timres_name(folder, num, freq, clue):
    """ searches for timeres filename (that fits params) in a folder and returns the name """
    for filename in os.listdir(folder):  # checks all files in given directory (where data should be)
        print(filename)
        print(str(num), str(freq), clue)
        if clue in filename:
            # NOTE: "clue" helps us differentiate between two with the same frequency (e.g. clue="figure_8")
            if f"numFrames({num})" in filename:
                if f"sineFreq({freq})" in filename:
                    if ".timeres" in filename:
                        #print("Using datafile:", filename)
                        return folder + filename    # this is our found timetag_file!
    print("No matching timeres file found! :(")
    return 'none'  # TODO FIXME

def get_image_path(folder_name):
    # Checks if image folders exists in a directory, otherwise it creates it
    directory = Path(__file__).parent  # or "file_path.parent"  # Note: "Path(__file__)" is the path for this script/code file
    save_image_path = directory.joinpath(f'{folder_name}')
    if not os.path.exists(save_image_path):  # If folder does not exist, create it
        os.makedirs(save_image_path)
    return save_image_path

# ----------- MAIN ANALYSIS --------------

def bap_eta_segmented_analysis_multiframe(const,scope_in_um=100):
    """Extracts and processes one frame at a time. Due to this we have to do all image processing within the function"""

    # --- LOAD RECIPE ---
    eta_engine = load_eta(const["eta_recipe"], bins=const["bins"], binsize=const["binsize"])  # NOTE: removed for test
    # ------ETA PROCESSING-----
    pos = 0           # internal ETA tracker (-> maybe tracks position in data list?)
    context = None    # tracks info about ETA logic, so we can extract and process data with breaks (i.e. in parts)
    image_nr = 0      # tracks which frame is being processed
    all_matrix = []   # for 3D animation
    all_histo = []

    # step 1) repeat extraction and creations of frames while there are more frames to be created
    all_figs = []

    while image_nr < const["nr_frames"]:  # note: maybe alternative condition
        histo_frame = []
        run_flag = True         # useful if run flag condition is used instead of "break"
        countrate_matrix = []   # to save data the same way it comes in (alternative to countrate list with more flexibility)
        row_nr = 0
        image_nr += 1           # note: image number starts at 1 and not 0 (i.e. not regular indexing)

        #print("-- image nr --", image_nr, "--")

        # step 2) Extracting rows until image is filled
        while run_flag:

            if const['speed_mode'] == 'fast':
                row, pos, context, run_flag = bap_get_row_from_eta(eta_engine=eta_engine, pos=pos, context=context, ch_sel=const["ch_sel"], timetag_file=const["timetag_file"], run_flag=run_flag, const=const)

                if row is None:
                    print("Row is None at:", row_nr)
                    continue

            elif const['speed_mode'] in ['slow', 'zoom']:  # *!!
                row = []
                save_pix = True
                for r in range(const['dimY']):  # for each pixel in the row
                    pix_nr, pix, pos, context, run_flag = bap_get_row_from_eta(eta_engine=eta_engine, pos=pos, context=context,  ch_sel=const["ch_sel"], timetag_file=const["timetag_file"], run_flag=run_flag, const=const)
                    print(f"pos is : {pos}")
                    if pix is None:
                        print("Pix is None at pix nr:", pix_nr)
                        save_pix = False
                        break

                    if row is None:
                        print("Row is None at row nr:", row_nr)
                        save_pix = False
                        break

                    if save_pix:
                        row.append(np.sum(pix))

                if row_nr % 2 == 1:  # flip every other row
                    row = np.flip(np.array(row))

            else:
                print("ERROR: UNRECOGNIZED SPEED MODE IN ETA ANALYSIS")

            #if row_nr <= const["dimX"]:
            if row_nr < const["dimX"]:
                countrate_matrix.append(list(row))
                histo_frame += list(row)
            else:
                pass #countrate_matrix.append(list(row))

            if row_nr == const["dimX"]:
                # At this point we have filled one full image and want to move onto the next image
                print(f"Frame {image_nr}/{const['nr_frames']} complete!")
                print("Final Row at:", row_nr)
                # break out of inner while loop to process current frame to then start on next frame:
                #break

            row_nr += 1
            print("row --", row_nr, "--")

        #  step 3) Flip every odd frame since we scan in different directions
        if image_nr % 2 == 1:  # note: indexing starts att 1 so odd frames are at even values of 'image_nr'
            print("FLIPPING FRAME")
            try:
                countrate_matrix = list(np.flip(np.array(countrate_matrix)))
            except:
                print("Failed to flip frame")
        #else:
        #    histo_frame.reverse()
        #    print("reversing frame", image_nr)

        all_histo.append(histo_frame)

        #  -------  PROCESS DATA INTO IMAGE: --------
        # step 4) create non-speed-adjusted image, compressing bins if needed
        non_speed_matrix = build_image_matrix(countrate_matrix, const["bins"], const["dimY"], const)  # raw images, flipping comparison
        print(f"---------------------- DATA START ------------------")
        #print(non_speed_matrix)
        np.savetxt("nonspeedmatrix.txt", non_speed_matrix,'%s')
        print(f"---------------------- DATA END ------------------")

        # step 6) create and save images of current frame:   # note: below two functions are needed to save figs and create gifs
        print("shape image matrix", np.array(non_speed_matrix).shape)
        fig_raw = draw_image_heatmap(matrix=np.array(non_speed_matrix), title=f"{const['clue']}",
                                                                              #f"Theoretical={1/const['scan_fps']} s",
                                     fig_title=f"Non-speed adjusted - sine freq: {const['freq']} Hz", save_fig=True,
                                     save_loc=const["save_location"], save_name=f"frame {image_nr}", figsize=(6,6), const=const, scope_in_um= scope_in_um)

        all_figs.append([fig_raw, non_speed_matrix])      # for GUI: fig and data
        # NOTE: SO FAR WE ONLY HAVE ONE

    #plt.show()
    print("Complete with ETA.")

    if False:
        for h in range(len(all_histo)):
            plt.figure(f"Histo for row {h+1}")
            plt.plot(all_histo[h])
            plt.title(f"Histo for row {h+1}")
            plt.show()

        for h in range(len(countrate_matrix)):
            plt.figure(f"Histos row {h}")
            plt.plot(countrate_matrix[h])
            plt.title(f"Histo for row {h+1}")
            plt.show()

    # step 7) create and save gifs with saved frames
    #for i in range(len(const['gif_rates'])):
    #i = 1
    #add_to_gif(location=const["save_location"], folder="/Original_Frames", const=const, gif_frame_rate=const['gif_rates'][i], note=const['gif_notes'][i], overlay=True)
    #add_to_gif(location=const["save_location"], folder="/Adjusted_Frames", const=const, gif_frame_rate=const['gif_rates'][i], note=const['gif_notes'][i], overlay=True)

    return all_figs

def bap_eta_segmented_analysis_multiframe_test0710(const,scope_in_um=100):
    """Extracts and processes one frame at a time. Due to this we have to do all image processing within the function"""

    # --- LOAD RECIPE ---
    eta_engine = load_eta("test22channels.eta", bins=const["bins"], binsize=const["binsize"])  # NOTE: removed for test
    # ------ETA PROCESSING-----
    pos = 0           # internal ETA tracker (-> maybe tracks position in data list?)
    context = None    # tracks info about ETA logic, so we can extract and process data with breaks (i.e. in parts)
    image_nr = 0      # tracks which frame is being processed
    all_matrix = []   # for 3D animation
    all_histo = []

    # step 1) repeat extraction and creations of frames while there are more frames to be created
    all_figs = []

    while image_nr < const["nr_frames"]:  # note: maybe alternative condition
        histo_frame = []
        run_flag = True         # useful if run flag condition is used instead of "break"
        countrate_matrix = []   # to save data the same way it comes in (alternative to countrate list with more flexibility)
        row_nr = 0
        image_nr += 1           # note: image number starts at 1 and not 0 (i.e. not regular indexing)

        #print("-- image nr --", image_nr, "--")

        # step 2) Extracting rows until image is filled
        while run_flag:

            if const['speed_mode'] == 'fast':
                row, pos, context, run_flag = bap_get_row_from_eta(eta_engine=eta_engine, pos=pos, context=context, ch_sel=const["ch_sel"], timetag_file=const["timetag_file"], run_flag=run_flag, const=const)

                if row is None:
                    print("Row is None at:", row_nr)
                    continue

            elif const['speed_mode'] in ['slow', 'zoom']:  # *!!
                row = []
                save_pix = True
                for r in range(const['dimY']):  # for each pixel in the row
                    pix_nr, pix, pos, context, run_flag = bap_get_row_from_eta(eta_engine=eta_engine, pos=pos, context=context,  ch_sel=const["ch_sel"], timetag_file=const["timetag_file"], run_flag=run_flag, const=const)

                    if pix is None:
                        print("Pix is None at pix nr:", pix_nr)
                        save_pix = False
                        break

                    if row is None:
                        print("Row is None at row nr:", row_nr)
                        save_pix = False
                        break

                    if save_pix:
                        row.append(np.sum(pix))

                if row_nr % 2 == 1:  # flip every other row
                    row = np.flip(np.array(row))

            else:
                print("ERROR: UNRECOGNIZED SPEED MODE IN ETA ANALYSIS")

            #if row_nr <= const["dimX"]:
            if row_nr < const["dimX"]:
                countrate_matrix.append(list(row))
                histo_frame += list(row)
            else:
                pass #countrate_matrix.append(list(row))

            if row_nr == const["dimX"]:
                # At this point we have filled one full image and want to move onto the next image
                print(f"Frame {image_nr}/{const['nr_frames']} complete!")
                print("Final Row at:", row_nr)
                # break out of inner while loop to process current frame to then start on next frame:
                #break

            row_nr += 1
            print("row --", row_nr, "--")

        #  step 3) Flip every odd frame since we scan in different directions
        if image_nr % 2 == 1:  # note: indexing starts att 1 so odd frames are at even values of 'image_nr'
            print("FLIPPING FRAME")
            try:
                countrate_matrix = list(np.flip(np.array(countrate_matrix)))
            except:
                print("Failed to flip frame")
        #else:
        #    histo_frame.reverse()
        #    print("reversing frame", image_nr)

        all_histo.append(histo_frame)

        #  -------  PROCESS DATA INTO IMAGE: --------
        # step 4) create non-speed-adjusted image, compressing bins if needed
        non_speed_matrix = build_image_matrix(countrate_matrix, const["bins"], const["dimY"], const)  # raw images, flipping comparison
        print(f"---------------------- DATA START ------------------")
        #print(non_speed_matrix)
        np.savetxt("nonspeedmatrix.txt", non_speed_matrix,'%s')
        print(f"---------------------- DATA END ------------------")

        # step 6) create and save images of current frame:   # note: below two functions are needed to save figs and create gifs
        print("shape image matrix", np.array(non_speed_matrix).shape)
        fig_raw = draw_image_heatmap(matrix=np.array(non_speed_matrix), title=f"{const['clue']}",
                                                                              #f"Theoretical={1/const['scan_fps']} s",
                                     fig_title=f"Non-speed adjusted - sine freq: {const['freq']} Hz", save_fig=True,
                                     save_loc=const["save_location"], save_name=f"frame {image_nr}", figsize=(6,6), const=const, scope_in_um= scope_in_um)

        all_figs.append([fig_raw, non_speed_matrix])      # for GUI: fig and data
        # NOTE: SO FAR WE ONLY HAVE ONE

    #plt.show()
    print("Complete with ETA.")

    if False:
        for h in range(len(all_histo)):
            plt.figure(f"Histo for row {h+1}")
            plt.plot(all_histo[h])
            plt.title(f"Histo for row {h+1}")
            plt.show()

        for h in range(len(countrate_matrix)):
            plt.figure(f"Histos row {h}")
            plt.plot(countrate_matrix[h])
            plt.title(f"Histo for row {h+1}")
            plt.show()

    # step 7) create and save gifs with saved frames
    #for i in range(len(const['gif_rates'])):
    #i = 1
    #add_to_gif(location=const["save_location"], folder="/Original_Frames", const=const, gif_frame_rate=const['gif_rates'][i], note=const['gif_notes'][i], overlay=True)
    #add_to_gif(location=const["save_location"], folder="/Adjusted_Frames", const=const, gif_frame_rate=const['gif_rates'][i], note=const['gif_notes'][i], overlay=True)
    print("test0710_22channels")
    return all_figs
def bap_eta_segmented_analysis_multiframe_spectrometer2(const,scope_in_um=100):
    """Extracts and processes one frame at a time. Due to this we have to do all image processing within the function"""
    nonspeedmatrix3D=[]
    for i in range(2,19):
    # --- LOAD RECIPE ---
        eta_engine = load_eta(f"recipe3D/18channel_re1ch{i}.eta", bins=const["bins"], binsize=const["binsize"])  # NOTE: removed for test
        # ------ETA PROCESSING-----
        pos = 0           # internal ETA tracker (-> maybe tracks position in data list?)
        context = None    # tracks info about ETA logic, so we can extract and process data with breaks (i.e. in parts)
        image_nr = 0      # tracks which frame is being processed
        all_matrix = []   # for 3D animation
        all_histo = []

        # step 1) repeat extraction and creations of frames while there are more frames to be created
        all_figs = []

        while image_nr < const["nr_frames"]:  # note: maybe alternative condition
            histo_frame = []
            run_flag = True         # useful if run flag condition is used instead of "break"
            countrate_matrix = []   # to save data the same way it comes in (alternative to countrate list with more flexibility)
            row_nr = 0
            image_nr += 1           # note: image number starts at 1 and not 0 (i.e. not regular indexing)

            #print("-- image nr --", image_nr, "--")

            # step 2) Extracting rows until image is filled
            while run_flag:

                if const['speed_mode'] == 'fast':
                    row, pos, context, run_flag = bap_get_row_from_eta(eta_engine=eta_engine, pos=pos, context=context, ch_sel=const["ch_sel"], timetag_file=const["timetag_file"], run_flag=run_flag, const=const)

                    if row is None:
                        print("Row is None at:", row_nr)
                        continue

                elif const['speed_mode'] in ['slow', 'zoom']:  # *!!
                    row = []
                    save_pix = True
                    for r in range(const['dimY']):  # for each pixel in the row
                        pix_nr, pix, pos, context, run_flag = bap_get_row_from_eta(eta_engine=eta_engine, pos=pos, context=context,  ch_sel=const["ch_sel"], timetag_file=const["timetag_file"], run_flag=run_flag, const=const)

                        if pix is None:
                            print("Pix is None at pix nr:", pix_nr)
                            save_pix = False
                            break

                        if row is None:
                            print("Row is None at row nr:", row_nr)
                            save_pix = False
                            break

                        if save_pix:
                            row.append(np.sum(pix))

                    if row_nr % 2 == 1:  # flip every other row
                        row = np.flip(np.array(row))

                else:
                    print("ERROR: UNRECOGNIZED SPEED MODE IN ETA ANALYSIS")

                #if row_nr <= const["dimX"]:
                if row_nr < const["dimX"]:
                    countrate_matrix.append(list(row))
                    histo_frame += list(row)
                else:
                    pass #countrate_matrix.append(list(row))

                if row_nr == const["dimX"]:
                    # At this point we have filled one full image and want to move onto the next image
                    print(f"Frame {image_nr}/{const['nr_frames']} complete!")
                    print("Final Row at:", row_nr)
                    # break out of inner while loop to process current frame to then start on next frame:
                    #break

                row_nr += 1
                print("row --", row_nr, "--")

            #  step 3) Flip every odd frame since we scan in different directions
            if image_nr % 2 == 1:  # note: indexing starts att 1 so odd frames are at even values of 'image_nr'
                print("FLIPPING FRAME")
                try:
                    countrate_matrix = list(np.flip(np.array(countrate_matrix)))
                except:
                    print("Failed to flip frame")
            #else:
            #    histo_frame.reverse()
            #    print("reversing frame", image_nr)

            all_histo.append(histo_frame)

            #  -------  PROCESS DATA INTO IMAGE: --------
            # step 4) create non-speed-adjusted image, compressing bins if needed
            non_speed_matrix = build_image_matrix(countrate_matrix, const["bins"], const["dimY"], const)  # raw images, flipping comparison
            print(f"---------------------- DATA START ------------------")
            #print(non_speed_matrix)
            np.savetxt("nonspeedmatrix.txt", non_speed_matrix,'%s')
            nonspeedmatrix3D.append(non_speed_matrix)
            print(f"---------------------- DATA END ------------------")

            # step 6) create and save images of current frame:   # note: below two functions are needed to save figs and create gifs
            print("shape image matrix", np.array(non_speed_matrix).shape)
            fig_raw = draw_image_heatmap(matrix=np.array(non_speed_matrix), title=f"{const['clue']}",
                                                                                  #f"Theoretical={1/const['scan_fps']} s",
                                         fig_title=f"Non-speed adjusted - sine freq: {const['freq']} Hz", save_fig=True,
                                         save_loc=const["save_location"], save_name=f"frame {image_nr}", figsize=(6,6), const=const, scope_in_um= scope_in_um)

            all_figs.append([fig_raw, non_speed_matrix])      # for GUI: fig and data
            # NOTE: SO FAR WE ONLY HAVE ONE

        #plt.show()
        print("Complete with ETA.")

        if False:
            for h in range(len(all_histo)):
                plt.figure(f"Histo for row {h+1}")
                plt.plot(all_histo[h])
                plt.title(f"Histo for row {h+1}")
                plt.show()

            for h in range(len(countrate_matrix)):
                plt.figure(f"Histos row {h}")
                plt.plot(countrate_matrix[h])
                plt.title(f"Histo for row {h+1}")
                plt.show()

        # step 7) create and save gifs with saved frames
        #for i in range(len(const['gif_rates'])):
        #i = 1
        #add_to_gif(location=const["save_location"], folder="/Original_Frames", const=const, gif_frame_rate=const['gif_rates'][i], note=const['gif_notes'][i], overlay=True)
        #add_to_gif(location=const["save_location"], folder="/Adjusted_Frames", const=const, gif_frame_rate=const['gif_rates'][i], note=const['gif_notes'][i], overlay=True)
    nonspeedmatrix3D = np.stack(nonspeedmatrix3D, axis=0)

    print(nonspeedmatrix3D.shape)  # (2, 2, 2)

    data_filename = const["timetag_file"].split("_scantime")[0] + ".json"
    data ={**const,** {
        #"timetag_file": const["timetag_file"],
        "matrix3D": nonspeedmatrix3D.tolist()
    }}
    with open(data_filename, 'w') as file:
        json.dump(data, file, indent=4)

    return all_figs
def bap_eta_segmented_analysis_multiframe_spectrometer(const,scope_in_um=100):
    """Extracts and processes one frame at a time. Due to this we have to do all image processing within the function"""

    # --- LOAD RECIPE ---
    eta_engine = load_eta("555.eta", bins=const["bins"], binsize=const["binsize"])  # NOTE: removed for test

    # ------ETA PROCESSING-----
    pos = 0           # internal ETA tracker (-> maybe tracks position in data list?)
    context = None    # tracks info about ETA logic, so we can extract and process data with breaks (i.e. in parts)
    image_nr = 0      # tracks which frame is being processed
    all_matrix = []   # for 3D animation
    all_histo = []

    # step 1) repeat extraction and creations of frames while there are more frames to be created
    all_figs = []

    while image_nr < const["nr_frames"]:  # note: maybe alternative condition
        histo_frame = []
        run_flag = True         # useful if run flag condition is used instead of "break"
        countrate_matrix = []   # to save data the same way it comes in (alternative to countrate list with more flexibility)
        row_nr = 0
        image_nr += 1           # note: image number starts at 1 and not 0 (i.e. not regular indexing)

        #print("-- image nr --", image_nr, "--")

        # step 2) Extracting rows until image is filled
        while run_flag:

            if const['speed_mode'] == 'fast':
                row, pos, context, run_flag = bap_get_row_from_eta(eta_engine=eta_engine, pos=pos, context=context, ch_sel=const["ch_sel"], timetag_file=const["timetag_file"], run_flag=run_flag, const=const)

                if row is None:
                    print("Row is None at:", row_nr)
                    continue

            elif const['speed_mode'] in ['slow', 'zoom']:  # *!!
                row = []
                save_pix = True
                for r in range(const['dimY']):  # for each pixel in the row
                    pix_nr, pix, pos, context, run_flag = bap_get_row_from_eta_spectrometer(eta_engine=eta_engine, pos=pos, context=context,  ch_sel=const["ch_sel"], timetag_file=const["timetag_file"], run_flag=run_flag, const=const)
                    # now that pix is a 2d array, with first demonsion indicating the channel
                    if pix is None:
                        print("Pix is None at pix nr:", pix_nr)
                        save_pix = False
                        break

                    if row is None:
                        print("Row is None at row nr:", row_nr)
                        save_pix = False
                        break

                    if save_pix:
                        row.append(np.sum(pix, axis=1))# shape (m, )
                #after append, give a (dimY,m)
                row = np.array(row)  # shape: (dimY, m)
                row = row.T  # shape: (m, dimY)
                if row_nr % 2 == 1:  # flip every other row
                    row = np.flip(row, axis=1)

            else:
                print("ERROR: UNRECOGNIZED SPEED MODE IN ETA ANALYSIS")

            #if row_nr <= const["dimX"]:
            if row_nr < const["dimX"]:
                countrate_matrix.append(row)
                histo_frame += list(row)
            else:
                pass #countrate_matrix.append(list(row))

            if row_nr == const["dimX"]:
                # At this point we have filled one full image and want to move onto the next image
                print(f"Frame {image_nr}/{const['nr_frames']} complete!")
                print("Final Row at:", row_nr)
                # break out of inner while loop to process current frame to then start on next frame:
                #break

            row_nr += 1
            print("row --", row_nr, "--")
        """for now we donot need to flip
        #  step 3) Flip every odd frame since we scan in different directions
        if image_nr % 2 == 1:  # note: indexing starts att 1 so odd frames are at even values of 'image_nr'
            print("FLIPPING FRAME")
            try:
                countrate_matrix = list(np.flip(np.array(countrate_matrix)))
            except:
                print("Failed to flip frame")
        #else:
        #    histo_frame.reverse()
        #    print("reversing frame", image_nr)
        """
        all_histo.append(histo_frame)
        countrate_matrix = np.stack(countrate_matrix, axis=1)  # shape: (n, dimX, dimY)
        print(f"test for spectrometer: now the shape of countrate_matrix is{countrate_matrix.shape}")
        #  -------  PROCESS DATA INTO IMAGE: --------
        # step 4) create non-speed-adjusted image, compressing bins if needed
        #non_speed_matrix = build_image_matrix(countrate_matrix, const["bins"], const["dimY"], const)  # raw images, flipping comparison
        non_speed_matrix_slices = []

        for i in range(countrate_matrix.shape[0]):  # loop over n
            slice_i = countrate_matrix[i, :, :]  # shape: (dimX, dimY)
            result = build_image_matrix(slice_i, const["bins"], const["dimY"], const)  # assume output is (dimX, dimY)
            non_speed_matrix_slices.append(result)

        non_speed_matrix = np.stack(non_speed_matrix_slices, axis=0)  # final shape: (n, dimX, dimY)

        print(f"---------------------- DATA START ------------------")
        #print(non_speed_matrix)
        #np.savetxt("nonspeedmatrix.txt", non_speed_matrix,'%s')
        print(f"test for spectrometer: now the shape of non_speed_matrix is{non_speed_matrix.shape}")
        print(f"---------------------- DATA END ------------------")

        # step 6) create and save images of current frame:   # note: below two functions are needed to save figs and create gifs
        print("shape image matrix", np.array(non_speed_matrix).shape)
        fig_raw = draw_image_heatmap(matrix=np.array(non_speed_matrix[0]), title=f"{const['clue']}",
                                                                              #f"Theoretical={1/const['scan_fps']} s",
                                     fig_title=f"Non-speed adjusted - sine freq: {const['freq']} Hz", save_fig=True,
                                     save_loc=const["save_location"], save_name=f"frame {image_nr}", figsize=(6,6), const=const, scope_in_um= scope_in_um)

        all_figs.append([fig_raw, non_speed_matrix])      # for GUI: fig and data
        # NOTE: SO FAR WE ONLY HAVE ONE

    #plt.show()
    print("Complete with ETA.")

    if False:
        for h in range(len(all_histo)):
            plt.figure(f"Histo for row {h+1}")
            plt.plot(all_histo[h])
            plt.title(f"Histo for row {h+1}")
            plt.show()

        for h in range(len(countrate_matrix)):
            plt.figure(f"Histos row {h}")
            plt.plot(countrate_matrix[h])
            plt.title(f"Histo for row {h+1}")
            plt.show()

    # step 7) create and save gifs with saved frames
    #for i in range(len(const['gif_rates'])):
    #i = 1
    #add_to_gif(location=const["save_location"], folder="/Original_Frames", const=const, gif_frame_rate=const['gif_rates'][i], note=const['gif_notes'][i], overlay=True)
    #add_to_gif(location=const["save_location"], folder="/Adjusted_Frames", const=const, gif_frame_rate=const['gif_rates'][i], note=const['gif_notes'][i], overlay=True)

    return all_figs
# ----------- ETA DATA --------------
def load_eta(recipe, **kwargs):
    print('Loading ETA')
    with open(recipe, 'r') as filehandle:
        recipe_obj = json.load(filehandle)
    #print("old:\n", recipe_obj)  # remove later

    eta_engine = etabackend.eta.ETA()
    eta_engine.load_recipe(recipe_obj)

    # Set parameters in the recipe
    for arg in kwargs:
        eta_engine.recipe.set_parameter(arg, str(kwargs[arg]))

    eta_engine.load_recipe()

    print("recipe loaded")
    return eta_engine

"""
    # Create an instance of the TimeTagger
    tagger = createTimeTagger()

    # Adjust trigger level on channel 1 to -0.25 Volt
    tagger.setTriggerLevel(-1, -0.25)   # <---- negative channel for negative voltage

    # Add time delay of 123 picoseconds on the channel 3
    tagger.setInputDelay(3, 123)


    # Run Correlation for 1 second to accumulate the data
    corr.startFor(int(1e12), clear=True)
    corr.waitUntilFinished()

    # Read the correlation data
    data = corr.getData()
    """

'''def get_row_from_eta(eta_engine, pos, context, ch_sel, timetag_file):

    # TODO: (for new timetagger) change clips below to contain channel nr (???)
    # NOTE FORMAT TYPES:
    """
    Value   |   ETA Constant/Name        |      Format for Device
    -----------------------------------------------------------------
    0           eta.FORMAT_PQ                   PicoQuant
    1           eta.FORMAT_SI_16bytes           Swabian Instrument binary
    2           eta.FORMAT_QT_COMPRESSED        compressed qutools quTAG binary
    3           eta.FORMAT_QT_RAW               raw qutools quTAG (?)
    4           eta.FORMAT_QT_BINARY            qutools quTAG 10-byte Binary
    5           eta.FORMAT_BH_spc_4bytes        Becker & Hickl SPC-134/144/154/830
    6           eta.FORMAT_ET_A033              Eventech ET A033
    """
    eta_format = eta_engine.FORMAT_SI_16bytes

    file_clips = eta_engine.clips(Path(timetag_file), seek_event=pos, format=eta_format)   # Note this is where we provide timetag file
    # -----
    result, context = eta_engine.run({"timetagger1": file_clips}, resume_task=context, return_task=True, group='qutag', max_autofeed=1)

    if result['timetagger1'].get_pos() == pos:
        # No new elements left
        return None, None, None

    pos = result['timetagger1'].get_pos()
    row = result[ch_sel]  # [result['X']]
    return row, pos, context
'''

def bap_get_row_from_eta(eta_engine, pos, context, ch_sel, timetag_file, run_flag, const=None):
    #eta_engine is a python object from the class
    # TODO: (for new timetagger) change clips below to contain channel nr (???)
    # NOTE FORMAT TYPES:
    """
    Value   |   ETA Constant/Name        |      Format for Device
    -----------------------------------------------------------------
    0           eta.FORMAT_PQ                   PicoQuant
    1           eta.FORMAT_SI_16bytes           Swabian Instrument binary
    2           eta.FORMAT_QT_COMPRESSED        compressed qutools quTAG binary
    3           eta.FORMAT_QT_RAW               raw qutools quTAG (?)
    4           eta.FORMAT_QT_BINARY            qutools quTAG 10-byte Binary
    5           eta.FORMAT_BH_spc_4bytes        Becker & Hickl SPC-134/144/154/830
    6           eta.FORMAT_ET_A033              Eventech ET A033
    """
    eta_format = eta_engine.FORMAT_SI_16bytes
    file_clips = eta_engine.clips(Path(timetag_file), seek_event=pos, format=eta_format)   # Note this is where we provide timetag file
    # -----
    #print(file_clips)
    result, context = eta_engine.run({"timetagger1": file_clips}, resume_task=context, return_task=True, group='qutag', max_autofeed=1)
    if result['timetagger1'].get_pos() == pos:
        # No new elements left
        run_flag = False
        #break
        if const['speed_mode'] in ['slow', 'zoom']:
            return result['X'], None, None, None, run_flag

        return None, None, None, run_flag

    if const['speed_mode'] in ['slow', 'zoom']:
        pos = result['timetagger1'].get_pos()
        pix = result[ch_sel]
        X = result['X']
        return X, pix, pos, context, run_flag

    pos = result['timetagger1'].get_pos()
    row = result[ch_sel]

    return row, pos, context, run_flag

def bap_get_row_from_eta_spectrometer(eta_engine, pos, context, ch_sel, timetag_file, run_flag, const=None):
    # in this one, the ch_sel should be exclueded? because we can get all the reslts from all channels?
    # TODO: (for new timetagger) change clips below to contain channel nr (???)
    # NOTE FORMAT TYPES:
    """
    Value   |   ETA Constant/Name        |      Format for Device
    -----------------------------------------------------------------
    0           eta.FORMAT_PQ                   PicoQuant
    1           eta.FORMAT_SI_16bytes           Swabian Instrument binary
    2           eta.FORMAT_QT_COMPRESSED        compressed qutools quTAG binary
    3           eta.FORMAT_QT_RAW               raw qutools quTAG (?)
    4           eta.FORMAT_QT_BINARY            qutools quTAG 10-byte Binary
    5           eta.FORMAT_BH_spc_4bytes        Becker & Hickl SPC-134/144/154/830
    6           eta.FORMAT_ET_A033              Eventech ET A033
    """
    eta_format = eta_engine.FORMAT_SI_16bytes

    #print(" ")
    #print(pos)
    file_clips = eta_engine.clips(Path(timetag_file), seek_event=pos, format=eta_format)   # Note this is where we provide timetag file
    # -----
    #print(file_clips)
    result, context = eta_engine.run({"timetagger1": file_clips}, resume_task=context, return_task=True, group='qutag', max_autofeed=1)

    if result['timetagger1'].get_pos() == pos:
        # No new elements left
        run_flag = False
        #break
        if const['speed_mode'] in ['slow', 'zoom']:
            return result['X'], None, None, None, run_flag

        return None, None, None, run_flag

    if const['speed_mode'] in ['slow', 'zoom']:
        pos = result['timetagger1'].get_pos()
        #pix = result[ch_sel]#change the ch_sel for test
        pix = []
        pix.append(result["h2"])
        pix=np.array(pix)
        X = result['X']  #what is result ['X'] ???
        return X, pix, pos, context, run_flag
    """it is returning to this one!!"""

    pos = result['timetagger1'].get_pos()
    row = result[ch_sel]
    return row, pos, context, run_flag

# ----------- DRAWING AND SAVING IMAGES --------------
def draw_image_heatmap(matrix, title="", fig_title="", cmap='hot', save_fig=False, save_loc="misc", save_name="misc", figsize=(5,5), const=None,scope_in_um = 100):
    """Generic method for any imshow() we want to do"""
    def smart_round(num):
        if abs(num - round(num)) < 0.05:  # 接近整数
            return round(num)  # 返回整数
        else:
            return round(num, 2)  # 保留2位小数

    rows, cols = matrix.shape
    positionx = round(8 * rows / 10)
    positiony = round(rows / 10)

    x_values = [positionx - round(rows / 10), positionx + round(rows / 10)]
    y_values = [positiony, positiony]
    # flipping or Transposing maybe needed the image because imshow() fills in from bottom (??)
    if False:
        fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=figsize)

        ax1.imshow(matrix, cmap=cmap)
        ax1.set_title("regular")
        ax1.axis('off')

        ax2.imshow(np.flip(matrix, axis=0), cmap=cmap)
        ax2.set_title("flip ax 0")
        ax2.axis('off')

        ax3.imshow(np.flip(matrix, axis=1), cmap=cmap)
        ax3.set_title("flip ax 1")
        ax3.axis('off')

        ax4.imshow(np.flip(matrix, axis=0).transpose(), cmap=cmap)
        ax4.set_title("transpose")
        ax4.axis('off')

    else:
        matrix1 = np.flip(matrix, axis=None)
        print(matrix.shape)
        np.savetxt("1023test.txt",matrix,'%s')
        fig, ax = plt.subplots(1, figsize=figsize) # , dpi=96)
        im = ax.imshow(matrix1.transpose(), cmap=cmap, origin='lower') #extent=[const['minX'], const['maxX'], const['minY'], const['maxY']])
        cbar = fig.colorbar(im, ax=ax)
        cbar.minorticks_on()
        ax.text(positionx - 0.8 * round(rows / 10), 0.3 * positiony, f"{smart_round(0.2 * scope_in_um)}\u03BCm",
                color="white",  fontsize=16, ) #fontweight='bold',
        plt.plot(x_values, y_values, color='white', linestyle='-', linewidth=3)
        ax.set_title(title)

    if True:
        text = f"{const['timetag_file'][12:]}"
        #fig.text(10, 450, text) #), fill=grey)  # , font=font)   # TODO: maybe increase font size
        lb = int(len(text)//2)+1
        for j in range(len(text)//lb + 1):
            #fig.text(0.05, 0.1-(j*0.02), text[j*lb:(j+1)*lb], fontsize='x-small') #), fill=grey)  # , font=font)   # TODO: maybe increase font size
            fig.text(0.05, 0.04-(j*0.02), text[j*lb:(j+1)*lb], fontsize=7) ##, fontsize='xx-small') #), fill=grey)  # , font=font)   # TODO: maybe increase font size

    if save_fig:
        tagfile = const['timetag_file']
        save_folder = get_image_path(save_loc)
        filename = f"{find_in_str('_date', tagfile)}_{find_in_str('_time', tagfile)}"

        # SAVE IMAGE
        plt.savefig(save_folder.joinpath(f'fig_{filename}'+".png"))


        # SAVE DATA
        data_str = []
        for row in matrix:
            vals = [str(int(x)) for x in row]
            data_str.append(' '.join(vals) + ' \n')

        with open(f"{save_folder}/data_{filename}.txt", 'w') as file:  # FIXME need to make sure that new scan => new/empty file
            file.writelines(data_str)  # TODO maybe add time of each


    return fig

def draw_image_heatmap_ratio(matrix, ratio, title="", timetag_file='',fig_title="", cmap='hot', save_fig=False, save_loc="misc", save_name="misc", figsize=(5,5), const=None,peaknumber =10,scope_in_um = 100):
    def smart_round(num):
        if abs(num - round(num)) < 0.05:  # 接近整数
            return round(num)  # 返回整数
        else:
            return round(num, 2)  # 保留2位小数

    rows, cols = matrix.shape
    positionx = round(8 * rows / 10)
    positiony = round(rows / 10)

    x_values = [positionx - round(rows / 10), positionx + round(rows / 10)]
    y_values = [positiony, positiony]

    """Generic method for any imshow() we want to do"""
    #analyzedmatrix, results = process_matrix(matrix)
    # flipping or Transposing maybe needed the image because imshow() fills in from bottom (??)
    if False:
        fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=figsize)

        ax1.imshow(matrix, cmap=cmap)
        ax1.set_title("regular")
        ax1.axis('off')

        ax2.imshow(np.flip(matrix, axis=0), cmap=cmap)
        ax2.set_title("flip ax 0")
        ax2.axis('off')

        ax3.imshow(np.flip(matrix, axis=1), cmap=cmap)
        ax3.set_title("flip ax 1")
        ax3.axis('off')

        ax4.imshow(np.flip(matrix, axis=0).transpose(), cmap=cmap)
        ax4.set_title("transpose")
        ax4.axis('off')

    else:
        #matrix1 = np.flip(matrix, axis=None)
        #matrix2 = matrix1.transpose()
        analyzedmatrix, results = peak_analysis.process_matrix_universalthresh(matrix, peaknumber)
        fig, ax = plt.subplots(1, figsize=figsize) # , dpi=96)
        im = ax.imshow(analyzedmatrix, cmap=cmap, vmin=0, vmax=np.max(matrix)*ratio, origin='lower' )#, origin='lower' #extent=[const['minX'], const['maxX'], const['minY'], const['maxY']])
        cbar = fig.colorbar(im, ax=ax)
        cbar.minorticks_on()
        ax.text(positionx - 0.8 * round(rows / 10), 0.3 * positiony, f"{smart_round(0.2 * scope_in_um)}\u03BCm",
                color="white",  fontsize=16, ) #fontweight='bold',
        plt.plot(x_values, y_values, color='white', linestyle='-', linewidth=3)
        ax.set_title(title)



        text = f"{timetag_file[12:]}"
        # fig.text(10, 450, text) #), fill=grey)  # , font=font)   # TODO: maybe increase font size
        lb = int(len(text) // 2) + 1
        for j in range(len(text) // lb + 1):
            # fig.text(0.05, 0.1-(j*0.02), text[j*lb:(j+1)*lb], fontsize='x-small') #), fill=grey)  # , font=font)   # TODO: maybe increase font size
            fig.text(0.05, 0.04 - (j * 0.02), text[j * lb:(j + 1) * lb],
                     fontsize=7)  ##, fontsize='xx-small') #), fill=grey)  # , font=font)   # TODO: maybe increase font size




        for res in results:
            x, y = res['position']
            ax.plot(x, y, 'b.', markersize=4) #mote that x and y is swapped
            intensity =  res['intensity']
            #ax.text(x, y, f"{sigma:.1f}", color="white", fontsize=8)
            ax.text(x, y, f"{intensity:.0f}", color="white", fontsize=8)  #({x},{y}) if we want the coordinate
    return fig

def find_in_str(term, search_str):
    try:
        return re.search(f'{term}\((.*?)\)', search_str).group(1)
    except:
        print(f"ERROR: Failed string search for '{term}' in '{search_str}'")
        return -1.0

def save_data(data, folder="", filename='scan_matrix', mode='w'):

    if not os.path.exists(folder):  # If folder does not exist, create it
        os.makedirs(folder)
        print("FOLDER CREATED")

    data_str = []
    for row in data:
        vals = [str(int(x)) for x in row]
        data_str.append(' '.join(vals) + ' \n')
    with open(f"{folder}/data_{filename}.txt", mode) as file:  # FIXME need to make sure that new scan => new/empty file
        file.writelines(data_str)  # TODO maybe add time of each


def draw_image_heatmap_3D(matrix, title="", fig_title="", cmap='hot'):  # , save_fig=False, save_loc="misc", save_name="misc"):
    matrix = np.flip(matrix)   # flips the image because imshow() fills in from bottom (??)

    X = np.arange(0, len(matrix[0]))
    Y = np.arange(0, len(matrix))
    X, Y = np.meshgrid(X, Y)

    plt.figure("3D "+fig_title)
    ax = plt.axes(projection='3d')
    surf = ax.plot_surface(X, Y, matrix, cmap=cmap, linewidth=0, antialiased=False)
    plt.title("3D "+title)
    plt.axis('off')
    #if save_fig:
    #    save_image_folder = get_image_path(save_loc)
    #    plt.savefig(save_image_folder.joinpath(f'3D_{save_name}'+".png"))

def animate_image_heatmap_3D(all_matrix, title="", fig_title="", cmap='hot', z_axis_lim=300):

    def data_gen(framenumber, data, plot):
        if framenumber == 0:
            time.sleep(2)
        # change matrix to next frame
        idx = framenumber % 10
        #print(idx, "/", len(all_matrix))
        data = all_matrix[idx]
        data = np.flip(data)  # flips the image because imshow() fills in from bottom (or differently than we scan??)

        # update plot with new data
        ax.clear()
        plot = ax.plot_surface(X, Y, data, **plot_args)
        plt.title(title + f" (frame: {idx+1})")
        #plt.xlim((0, 100))
        #plt.ylim((0, 100))
        ax.set_zlim(0, z_axis_lim)

        azim = 225 + 10*framenumber   # 360/10
        ax.view_init(azim=azim, elev=60.)  # ax.view_init(elev=200., azim=45)
        plt.axis('off')

        return plot,

    matrix = np.flip(all_matrix[0])  # flips the image because imshow() fills in from bottom (??)

    #plot_args = {'rstride': 1, 'cstride': 1, 'cmap': cm.bwr, 'linewidth': 0.01, 'antialiased': True, 'color': 'w', 'shade': True}  # TODO ??
    plot_args = {'rstride': 1, 'cstride': 1, 'cmap': cmap, 'linewidth': 0, 'antialiased': False, 'color': 'w', 'shade': True}  # TODO ??

    fig = plt.figure(fig_title)     # NOTE: Unsure if this goes here
    ax = plt.axes(projection='3d')  # NOTE unsure if this goes here

    # first frame
    X = np.arange(0, len(matrix[0]))
    Y = np.arange(0, len(matrix))
    # Z = np.zeros((len(matrix[0]), len(matrix))) # TODO?
    # Z[len(matrix[0])//2, len(matrix)//2] = 1  # TODO?? midpoint?
    X, Y = np.meshgrid(X, Y)

    surf = ax.plot_surface(X, Y, matrix, **plot_args)  # surf = ax.plot_surface(X, Y, matrix, cmap=cmap, linewidth=0, antialiased=False)
    plt.title(title)
    plt.xlim((0, 100))
    plt.ylim((0, 100))
    ax.set_zlim(0, z_axis_lim)  # TODO
    ax.view_init(azim=225, elev=30.)   # ax.view_init(elev=200., azim=45)
    plt.axis('off')

    anim = animation.FuncAnimation(fig, data_gen, fargs=(matrix, surf), interval=50, blit=False)

    # Alternatively save animation to gif
    #anim = animation.FuncAnimation(fig, data_gen, fargs=(matrix, surf), interval=50, repeat=True, save_count=36)
    #print("Done with animation")
    #writergif = animation.PillowWriter(fps=3)
    #anim.save("3D_animation.gif", writer=writergif)
    plt.show()

def add_to_gif(location, folder, const, gif_frame_rate, note="", overlay=False):
    # Take saved images and make a gif:
    #   altered from -> https://pythonprogramming.altervista.org/png-to-gif/?doing_wp_cron=1693215726.9461410045623779296875
    frames = []
    grey = (105, 105, 105)   # RGB color for extra text   #black = (0, 0, 0)

    for i in range(1, const['nr_frames']+1):
        img = location + folder + f"/frame {i}.png"
        new_frame = Image.open(img)

        # Additional text added to gif such as playback frame rate and timestamp of used timeres
        if overlay:
            draw_frame = ImageDraw.Draw(new_frame)
            text = f"Playback: {gif_frame_rate} fps  {note}\nScan timestamp: {const['timetag_file'][-27:-25]}/{const['timetag_file'][-29:-27]}/20{const['timetag_file'][-31:-29]} ({const['timetag_file'][-18:-9]})"
            draw_frame.text((10, 450), text, fill=grey)  # , font=font)   # TODO: maybe increase font size
        frames.append(new_frame)

    # Save into a GIF file that loops forever. gif delay time is equal to the frame time, in milliseconds
    frames[0].save(location + f"/{folder[1:-7]}_scan({const['scan_fps']}fps)_playback({gif_frame_rate}fps).gif", format='GIF', append_images=frames[1:], save_all=True, duration=1000/gif_frame_rate, loop=0)  # param: duration=1000[ms]/n[fps].  10 fps => 100 duration

# ----------- DATA PROCESSING: NON-SPEED ADJUSTED --------------
def build_image_matrix(countrate_matrix, bins, dimY, const):
    img = []
    test_temp = False

    if const['speed_mode'] == 'fast':
        nrsweeps = 2
    else:
        nrsweeps = 1

    if bins > nrsweeps*dimY:   # <- compressing/combining bins to get square pixels
        print("COMPRESSING PIXELS")
        for row in countrate_matrix:
            if nrsweeps == 2:
                combined_flipped = list(np.array(row[:int(bins / 2)]) + np.array(np.flip(row[int(bins / 2):])))
                #combined_flipped = list(np.array(row[:int(bins / 2)]))   # + np.array(np.flip(row[int(bins / 2):])))
                #combined_flipped = list(np.array(row[int(bins / 2):]))  # + np.array(np.flip(row[int(bins / 2):])))
            else:
                combined_flipped = list(np.array(row))   # maybe over doing it but for now it works, TODO: return to and simplify for slow mode
            img.append(compress_bins_into_pixels(bins=bins, pixY=dimY, row=combined_flipped, nr_sweeps=nrsweeps))
    elif test_temp:
        print("TEST COMB")
        for row in countrate_matrix:
            combined_flipped = list(np.array(row))
            # combined_flipped = list(np.array(row[:int(bins / 2)]) + np.array(row[int(bins / 2):]))
            img.append(combined_flipped)
    elif bins == nrsweeps*dimY:
        print("REGULAR PIXELS")
        for row in countrate_matrix:
            if nrsweeps == 2:
                combined_flipped = list(np.array(row[:int(bins / 2)]) + np.array(np.flip(row[int(bins / 2):])))
                combined_flipped = np.array(np.flip(row[int(bins / 2):]))
                #combined_flipped = list(np.array(row[:int(bins / 2)]))
            else:
                combined_flipped = list(np.array(row))   # maybe over doing it but for now it works, TODO: return to and simplify for slow mode
            img.append(combined_flipped)
    else:
        print("ERROR: TOO FEW BINS FOR IMAGING (in 'build_image_matrix')")

    print(len(img), len(img[0]))
    return img

def compress_bins_into_pixels(bins, pixY, row, n_sweeps = 2):
    """ Compresses bins into pixel values. argument "row" = combined row (from multiple sweeps) or a row for a single sweep"""
    compressed_list = []
    #n_sweeps = 2        # here we need to account input argument "row" being one sweep, while bins includes all sweeps
    extra = int(round(bins / (n_sweeps * pixY)))   # if (bins = 40000)  --> (after we've combined two sweeps -> bins_combined = bins/2 = 20000) and  (dimY = 100)  --> bins_combined/dimY = 200  --> we need to compress every 200 values into one
    for i in range(pixY):
        pixel_sum = sum(row[i * extra:(i + 1) * extra])   # sum values in bins to make up one equally sized pixel
        compressed_list.append(pixel_sum)

    return compressed_list
