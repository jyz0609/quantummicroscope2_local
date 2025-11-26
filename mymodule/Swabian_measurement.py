# make the right import!
import os.path
import time
import numpy
import TimeTagger
import etabackend.eta as eta  # Available at: https://github.com/timetag/ETA, https://eta.readthedocs.io/en/latest/
import etabackend.tk as etatk
# file: test_live_plot.py
import matplotlib
# 如果你怀疑后端有问题，可以强制用 TkAgg（GUI 后端）
matplotlib.use("TKAgg")
import matplotlib.pyplot as plt


class run_swabian:
    #This function defines the filepath when create the object
    def __init__(self,filepath=""):
        import os
        self.absolute_folder = os.path.dirname(os.path.abspath(__file__))
        #print(f"self absolute path = {self.absolute_folder}")
        if filepath == "":
            filepath = os.path.join(os.path.dirname(os.path.abspath(__file__)),"test.timeres")
            print(f"no filepath yet. if not updated, will save it as test.timeres")
        self.timeres_file = filepath
        if not os.path.exists(os.path.dirname(filepath)):
            os.makedirs(os.path.dirname(filepath), exist_ok=True)
        self.tagger=None
        self.channel_list = [1,2,3,4]

    def connect(self):
        self.tagger = TimeTagger.createTimeTagger()
        # create the timetagger object
        self.chan_list = self.tagger.getChannelList(TimeTagger.TT_CHANNEL_RISING_EDGES)
        self.chan_list = list(self.channel_list)
        print(f"self channel list is {self.chan_list}")
        # get all the available channels from the list
        for ch in self.chan_list:
            self.tagger.setTriggerLevel(ch, 0.125)
        # set the trigger level of signal channels
        marker_ch = 4
        self.tagger.setTriggerLevel(marker_ch, 0.2)
        # set the trigger level of the marker channel. The current marker channel is 4, but this can be changed if the recipe is modified accordingly
    def start_dump(self):
        self.dump = TimeTagger.Dump(tagger=self.tagger, filename=self.timeres_file, max_tags=-1,
                                    channels=self.channel_list)
        # creat the dump object to record data
        self.dump.stop()
        self.dump.start()

    def stop_dump(self):
        self.dump.stop()
        #the tagger need to be freed after one measurement

    def free(self):
        TimeTagger.freeTimeTagger(self.tagger)
        print("tagger freed and connection terminated. If need another measurement, create a new object")

    def dump_time(self, measuringtime = 1):
        print(f"dumping file for {measuringtime} seconds")
        self.dump = TimeTagger.Dump(tagger=self.tagger, filename=self.timeres_file, max_tags=-1,
                                    channels=self.chan_list)
        # creat the dump object to record data
        self.dump.start()
        time.sleep(measuringtime)
        self.dump.stop()
        print(f"finished dumping after{measuringtime} seconds")

    def get_countrate(self,channels = None):
        if channels is None:
            channels = [2, 3]
        print("waiting 2s for stable count")
        time.sleep(2)
        print("getting count rate for 5s")
        counter = TimeTagger.Countrate(self.tagger, channels)
        time.sleep(5)
        countratearr = counter.getData()
        first = round(float(countratearr[0]), 4)
        second = round(float(countratearr[1]), 4)
        #print(f"it gets {counter.getCountsTotal()} counts in total")
        counter.clear()
        # 1103: do not know if it will work when multiple countrate is called. maybe use total count to see.
        print(f"first channel countrate =  {first}, second channel countrate = {second}")
        return first , second
    def correlation_realtime(self,measuringtime = 10,channels = None):
        if channels is None:
            channels = [2, 3]
        correlation = TimeTagger.Correlation(tagger = self.tagger,
        channel_1 = channels[0],
        channel_2 = channels[1],
        binwidth = 200,
        n_bins = 200)
        correlation.stop()
        correlation.startFor(int(measuringtime*1E12))

        plt.ion()

        fig, ax = plt.subplots()
        ax.set_xlabel("Time difference (ns)")
        ax.set_ylabel("Counts")

        # 只要外部还在跑，就持续刷新
        while correlation.isRunning():
            x = correlation.getIndex()/int(1000)
            y = correlation.getData()

            ax.clear()
            ax.plot(x, y)
            ax.set_xlabel("Time difference (ns)")
            ax.set_ylabel(f"Counts")
            fig.canvas.draw_idle()
            plt.pause(0.5)  # 让图窗有时间响应 & 刷新
        plt.ioff()
        plt.close(fig)







if __name__ == "__main__":
    tagger = run_swabian()
    tagger.start_dump()
    tagger.stop_dump()