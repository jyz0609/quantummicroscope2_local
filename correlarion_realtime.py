import mymodule.Swabian_measurement as Swabian
import threading
from multiprocessing import Process
timetaggerx = Swabian.run_swabian()
timetaggerx.connect()
measuringtime = 5
p= Process(target=timetaggerx.correlation_realtime,args=(measuringtime,))
#timetaggerx.correlation_realtime(measuringtime=5)
p.start()

