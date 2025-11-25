"""In this example, we learn how to start a simple measurement. We use the Counter class to measure a
count rate trace on channels 1 and 2 while switching on the built-in test signals.
For a demonstration of Counter.getDataObject(), see example 2-E."""
"""
 This example is used to test the basic functions of filewriter, virtual tagger and the real time plotting using python plt. 
"""
from TimeTagger import Correlation, Countrate
from matplotlib import pyplot as plt
from time import sleep
import time
import TimeTagger

import matplotlib

def set_test_signal(tagger):
    for i in range(4):
        tagger.setTestSignal(1, True)
        print("Test signal on channel 1 enabled")
        sleep(1)
        tagger.setTestSignal(1, False)
        print("Test signal on channel 1 disabled")
        sleep(1)

import threading
matplotlib.use('TkAgg')  # or 'Qt5Agg' if you're on Linux and have PyQt5 installed
def write_file(filename):
    # Create a TimeTagger instance to control your hardware
    tagger = TimeTagger.createTimeTagger()

    # Create an instance of the Counter measurement class. It starts acquiring data immediately.
    fw = TimeTagger.FileWriter(tagger, filename, [1,2])

    counter = TimeTagger.Counter(tagger=tagger, channels=[1, 2], binwidth=int(1e9), n_values=10000)
    #corr = Correlation(tagger=tagger,channel_1=1,channel_2=1, binwidth=int(1e9),  n_bins = 100)
    counter.stop()
    counter.startFor(int(7E12))
    #corr.start()

    # Apply the built-in test signal (~0.8 to 0.9 MHz) to channel 1
    #sleep(1)
    #tagger.setTestSignal(1, True)
    #print("Test signal on channel 1 enabled")
    #sleep(1)
    ##corr.stop()
    ## Apply test signal to channel 2
    #tagger.setTestSignal(2, True)
    #print("Test signal on channel 2 enabled")

    # After waiting two times for 0.5 s, the 1000 values should be filled
    #sleep(.5)
    #print("filewrirer stopped")
    #fw.stop()

    # Data is retrieved by calling the method "getData" on the measurement class.
    #corr_array = corr.getData()

    threading.Thread(target=set_test_signal, args=(tagger,)).start()

    # We let the measurements run for 10 s and watch the data accumulation
    fig = plt.figure()


    while counter.isRunning():
        time_before = time.time()
        fig.clear()
        data= counter.getData()[0]
        plt.plot(data)
        plt.xlabel("Time difference (ps)")
        plt.ylabel("Counts")
        plt.ylim(-10, 910)
        time_after = time.time()
        wait_time = time_after - time_before
        print(f"wait_time: {wait_time}")
        plt.pause(.1)
    TimeTagger.freeTimeTagger(tagger)


#write_file('filewritertest2/counter2.ttbin')
#print(data)
#
## Plot it
#plt.plot(data[0])
#plt.title("1D Array Plot")
#plt.xlabel("Index")
#plt.ylabel("Value")
#plt.show()

# Plot the result
#plt.figure()
##plt.plot(counter.getIndex()/1e12, data[0]*1e-3, label='channel 1')
#plt.plot(counter.getIndex()/1e12, data[1]*1e-3, label='channel 2')
#plt.xlabel('Time (s)')
#plt.ylabel('Countrate (MHz)')
#plt.legend()
#plt.title('Time trace of the click rate on channel 1 and 2')


#plt.annotate('''The built-in test signal(~ 800 to 900 kHz) is applied
#first to channel 1 and 0.5 s later to channel 2.
#The total delay time within the script is 1 s.
#As you can see, the counts are still 0 at 0 s.
#The Time Tagger and the analysis software are
#running asynchronously. Therefore, the total processed
#data is less than 1 s. To have an exact measurement
#duration, please use startFor() instead of sleep().''',
#             (0, 0),
#             xytext=(100, 100),
#             textcoords='offset pixels',
#             arrowprops={'arrowstyle': '->'},
#             va='bottom')

#plt.tight_layout()
#plt.show()

def read_file(filename):
    time_before = time.time()
    tagger = TimeTagger.createTimeTaggerVirtual(filename=filename)
    counter = TimeTagger.Counter(tagger=tagger, channels=[1, 2], binwidth=int(1e9), n_values=10000)
    tagger.run()
    is_running = True
    fig = plt.figure()
    while is_running:
        is_running = not tagger.waitUntilFinished(timeout=0)

        fig.clear()
        data= counter.getData()[0]
        plt.plot(data)
        plt.xlabel("Time difference (ps)")
        plt.ylabel("Counts")
        plt.ylim(-10, 910)

        plt.pause(.1)
    plt.show(block=True)
    time_after = time.time()
    wait_time = time_after - time_before
    print(f"wait_time: {wait_time}")

    TimeTagger.freeTimeTagger(tagger)

read_file('filewritertest2/counter2.ttbin')