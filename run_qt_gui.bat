@echo off
set "CONDA_ENV=C:\Users\87691\anaconda3\envs\lidar0408ver2"
set "PATH=%CONDA_ENV%;%CONDA_ENV%\Scripts;%CONDA_ENV%\Library\bin;%PATH%"
cd /d "%~dp0"
"%CONDA_ENV%\python.exe" "qt_app.py"
pause
