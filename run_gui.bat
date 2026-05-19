@echo off
set "CONDA_ENV=C:\Users\87691\anaconda3\envs\lidar0408ver2"
set "PATH=%CONDA_ENV%;%CONDA_ENV%\Scripts;%CONDA_ENV%\Library\bin;%PATH%"
cd /d "%~dp0"
if not exist ".matplotlib_cache" mkdir ".matplotlib_cache"
set "MPLCONFIGDIR=%CD%\.matplotlib_cache"
set "TCL_LIBRARY=%CONDA_ENV%\Library\lib\tcl8.6"
set "TK_LIBRARY=%CONDA_ENV%\Library\lib\tk8.6"
"%CONDA_ENV%\python.exe" "Microscope_GUI_ver2.py"
pause
