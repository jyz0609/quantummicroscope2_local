import re
import TimeTagger
import os
import time


class run_swabian:
    #This function defines the filepath when create the object
    def __init__(self,filepath=""):
        self.class_absolute_path = os.path.dirname(os.path.abspath(__file__))
        print(f"self absolute path = {self.class_absolute_path}")
        self.swabian_file = filepath
        if not os.path.exists(os.path.dirname(filepath)):
            os.makedirs(os.path.dirname(filepath), exist_ok=True)

        self.tagger = TimeTagger.createTimeTagger()
        #create the timetagger object
        self.chan_list = self.tagger.getChannelList(TimeTagger.TT_CHANNEL_RISING_EDGES)
        #get all the available channels from the list
        for ch in self.chan_list:
            self.tagger.setTriggerLevel(ch, 0.125)
        #set the trigger level of signal channels
        marker_ch = 4
        self.tagger.setTriggerLevel(marker_ch, 0.2)
        #set the trigger level of the marker channel. The current marker channel is 4, but this can be changed if the recipe is modified accordingly

        self.dump = TimeTagger.Dump(tagger=self.tagger, filename=self.swabian_file, max_tags=-1,
                            channels=self.chan_list)
        #creat the dump object to record data
    def start(self):
        self.dump.start()

    def stop(self):
        self.dump.stop()
        #the tagger need to be freed after one measurement
    def free(self):
        TimeTagger.freeTimeTagger(self.tagger)
        print("tagger freed and connection terminated. If need another measurement, create a new object")

    def get_countrate(self,channels = [2, 3]):
        print("waiting 2s for stable count")
        time.sleep(2)
        print("getting count rate")
        counter = TimeTagger.Countrate(self.tagger, channels)
        time.sleep(3)
        countratearr = counter.getData()


if __name__ == "__main__":

    # Example usage
    filepath = "K:/Microscope/Data/250310/infotest_date(250310)_time(15h57m14s)_scantime(200.0)_dwellTime(0.005)_xAmp(0.31949)_yAmp(0.31949)_xyDim(200).timeres"
    tagger = run_swabian(filepath=filepath)
    tagger.start()
    time.sleep()
    tagger.stop()



if __name__ == "__main__":

    # Example usage
    filepath = "K:/Microscope/Data/250310/infotest_date(250310)_time(15h57m14s)_scantime(200.0)_dwellTime(0.005)_xAmp(0.31949)_yAmp(0.31949)_xyDim(200).timeres"
    tagger = run_swabian(filepath=filepath)
    count = TimeTagger.Countrate(tagger.tagger,[2,3])
    time.sleep(2)
    countratearr= count.getData()
    print(f"countrate = {count.getData()}")
    print(type(countratearr))
    TimeTagger.freeTimeTagger(tagger.tagger)
    first = round(float(countratearr[0]),4)
    second = round(float(countratearr[1]),4)
    print(f"first =  {first}, second = {second}")