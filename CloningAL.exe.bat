@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=
REM BFCPEICON=
REM BFCPEICONINDEX=-1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=0
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=0
REM BFCPEVERVERSION=1.0.0.0
REM BFCPEVERPRODUCT=Product Name
REM BFCPEVERDESC=Product Description
REM BFCPEVERCOMPANY=Your Company
REM BFCPEVERCOPYRIGHT=Copyright Info
REM BFCPEWINDOWCENTER=1
REM BFCPEDISABLEQE=0
REM BFCPEWINDOWHEIGHT=30
REM BFCPEWINDOWWIDTH=120
REM BFCPEWTITLE=Window Title
REM BFCPEOPTIONEND
@echo off

mkdir C:\Aliens

cd C:\Aliens && git clone -b main git@github.com:AliensCyborg/.github.git
cd C:\Aliens && git clone -b main git@github.com:AliensCyborg/Cyborg.git
cd C:\Aliens && git clone -b main git@github.com:Aliens-Company/Feedback.git
cd C:\Aliens && git clone -b main git@github.com:Aliens-Company/Blog.git

cd C:\Aliens && git clone -b main git@github.com:Aliens-Company/Docs.git
cd C:\Aliens && git clone -b main git@github.com:Aliens-Company/Report.git
cd C:\Aliens && git clone -b main git@github.com:Aliens-Company/Project.git
cd C:\Aliens && git clone -b main git@github.com:Aliens-Company/Attendance.git
cd C:\Aliens && git clone -b Empty git@github.com:Aliens-Company/.Alien.git
cd C:\Aliens && git clone -b main git@github.com:Aliens-Company/WebApp.git
cd C:\Aliens && git clone -b main git@github.com:Aliens-Company/WebSDK.git

pause