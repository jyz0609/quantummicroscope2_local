
from . import CNN_classifier as cla
from . import ETA_analysis as ana
from . import Swabian_measurement as mea
import os



from typing import Optional


"""important!! using This mudule means that you need to have a local Timetagger !!

"""

def measure_save_classify(timeres_file = "",timetagger: Optional[mea.run_swabian] = None, N=3,bins = 100,binsize = 200) -> mea.run_swabian:

    # timetagger is an instance of run_swabian
    # it needs a running swabian file, and a timetagger object. return to the possibility of judging
    # the timeres file should be the file when the measuring timeres file will be saved. so it only measure and save
    if timetagger is None:
        timetagger = mea.run_swabian(timeres_file)       # <-- instantiate!
    if timetagger.tagger is None:
        timetagger.connect()
    # ... do work ...
    if timeres_file == "":
        timeres_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), "test.timeres")
    timetagger.timeres_file = timeres_file
    print(f"now saving to {timeres_file}")
    r1, r2 = timetagger.get_countrate()
    measuringtime = N/(r1*r2*binsize*(1e-12))
    timetagger.dump_time(measuringtime=measuringtime)
    eta_recipe = os.path.join(os.path.dirname(os.path.abspath(__file__)), "ch2_ch3_normalized.eta")
    #start eta analysis
    eta_engine = ana.load_eta(eta_recipe, bins=bins, binsize=binsize, delay_1 = 0 )
    g2_onedirection = ana.analyze_savepng_returnonedirection(timetag_file=timeres_file,eta_engine=eta_engine,measuringtime=measuringtime)
    prob = cla.normalized(arr=g2_onedirection)
    print(f"the probability to be SPE is {1-prob}")
    #prob closer to 0: more likely to be SPE
    return prob
