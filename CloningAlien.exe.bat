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
setlocal EnableDelayedExpansion

echo Generating SSH Key...
ssh-keygen -t rsa -b 4096 -C "anil.cyborg.assistant@gmail.com"

echo.
echo SSH Generate ho Gyi h Add kr de !
set /p SSHDONE=Type Done After Adding SSH Key: 

if /I NOT "%SSHDONE%"=="Done" (
    echo Wrong Input
    pause
    exit
)

git config --global user.name "Anil Cyborg"
git config --global user.email "anil.cyborg.assistant@gmail.com"

mkdir C:\Aliens

echo.
echo Cloning Repositories...

cd /d C:\Aliens && git clone -b main git@github.com:AliensCyborg/.github.git
cd /d C:\Aliens && git clone -b main git@github.com:AliensCyborg/Cyborg.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Feedback.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Blog.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Docs.git
cd C:/Aliens && git clone -b main git@github.com:Aliens-Company/Website.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Report.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Project.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Attendance.git
cd /d C:\Aliens && git clone -b Empty git@github.com:Aliens-Company/.Alien.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/WebApp.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/WebSDK.git

echo.
echo All Repositories Cloned Successfully!

echo.
set /p BRANCHNAME=Enter Branch Name For All Repositories: 
set /p OLDID=Enter Old Device ID: 
set /p NEWID=Enter New Device ID: 

echo.
echo Creating Branches And Updating .Alien...

cd /d C:\Aliens\.Alien

git checkout -b %BRANCHNAME%

echo.
echo Old ID = %OLDID%
echo New ID = %NEWID%

if exist "%OLDID%" (
    ren "%OLDID%" "%NEWID%"
) else (
    xcopy Alien "%NEWID%" /E /I /Y
)

echo.
echo ==========================================
echo Please Update manifest.json Manually
echo OLD ID = %OLDID%
echo NEW ID = %NEWID%
echo ==========================================

pause

set /p MANIFESTDONE=Type Done After Updating manifest.json : 

if /I NOT "%MANIFESTDONE%"=="Done" (
    echo Wrong Input
    pause
    exit
)

git add .

git commit -m "Created %NEWID%"

git push -u origin %BRANCHNAME%

cd /d C:\Aliens\Project
git checkout main
git pull origin main
git checkout -b %BRANCHNAME%
git push -u origin %BRANCHNAME%

cd /d C:\Aliens\Attendance
git checkout main
git pull origin main
git checkout -b %BRANCHNAME%
git push -u origin %BRANCHNAME%

cd /d C:\Aliens\Report
git checkout main
git pull origin main
git checkout -b %BRANCHNAME%
git push -u origin %BRANCHNAME%

cd /d C:\Aliens\WebApp
git checkout beta
git pull origin beta
git checkout -b %BRANCHNAME%
git push -u origin %BRANCHNAME%

cd /d C:\Aliens\WebSDK
git checkout beta
git pull origin beta
git checkout -b %BRANCHNAME%
git push -u origin %BRANCHNAME%

cd /d C:\Aliens\Docs
git checkout beta
git pull origin beta
git checkout -b %BRANCHNAME%
git push -u origin %BRANCHNAME%

echo.
echo All Branches Created And Pushed Successfully!

pause
