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

REM =========================
REM STATUS VARIABLES
REM =========================

set SSH_STATUS=Done
set CLONE_STATUS=Done
set ALIEN_STATUS=Done
set BRANCH_STATUS=Done
set PUSH_STATUS=Done

echo Generating SSH Key...
ssh-keygen -t rsa -b 4096 -C "anil.cyborg.assistant@gmail.com"

if errorlevel 1 set SSH_STATUS=Failed

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

if not exist C:\Aliens mkdir C:\Aliens

echo.
echo Cloning Repositories...

cd /d C:\Aliens && git clone -b main git@github.com:AliensCyborg/.github.git
if errorlevel 1 set CLONE_STATUS=Failed

cd /d C:\Aliens && git clone -b main  git@github.com:AliensCyborg/Cyborg.git
if errorlevel 1 set CLONE_STATUS=Failed

cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Feedback.git
if errorlevel 1 set CLONE_STATUS=Failed

cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Blog.git
if errorlevel 1 set CLONE_STATUS=Failed

cd /d C:\Aliens && git clone -b beta git@github.com:Aliens-Company/Docs.git
if errorlevel 1 set CLONE_STATUS=Failed

cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Website.git
if errorlevel 1 set CLONE_STATUS=Failed

cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Report.git
if errorlevel 1 set CLONE_STATUS=Failed

cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Project.git
if errorlevel 1 set CLONE_STATUS=Failed

cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Attendance.git
if errorlevel 1 set CLONE_STATUS=Failed

cd /d C:\Aliens && git clone -b Empty git@github.com:Aliens-Company/.Alien.git
if errorlevel 1 set CLONE_STATUS=Failed

cd /d C:\Aliens && git clone -b beta git@github.com:Aliens-Company/WebApp.git
if errorlevel 1 set CLONE_STATUS=Failed

cd /d C:\Aliens && git clone -b beta git@github.com:Aliens-Company/WebSDK.git
if errorlevel 1 set CLONE_STATUS=Failed

echo.
echo All Repositories Cloning Process Completed!

echo.
set /p BRANCHNAME=Enter Branch Name For All Repositories:
set /p OLDID=Enter Old Device ID:
set /p NEWID=Enter New Device ID:

echo.
echo Creating Branches And Updating .Alien...

cd /d C:\Aliens\.Alien

git checkout -b %BRANCHNAME%

if errorlevel 1 (
    git checkout %BRANCHNAME%
    if errorlevel 1 set BRANCH_STATUS=Failed
)

echo.
echo Old ID = %OLDID%
echo New ID = %NEWID%

if exist "%OLDID%" (
    ren "%OLDID%" "%NEWID%"
    if errorlevel 1 set ALIEN_STATUS=Failed
) else (
    xcopy Alien "%NEWID%" /E /I /Y
    if errorlevel 1 set ALIEN_STATUS=Failed
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
if errorlevel 1 set PUSH_STATUS=Failed

cd /d C:\Aliens\Project
git checkout main
git pull origin main
git checkout -b %BRANCHNAME%
if errorlevel 1 git checkout %BRANCHNAME%
git push -u origin %BRANCHNAME%
if errorlevel 1 set PUSH_STATUS=Failed

cd /d C:\Aliens\Attendance
git checkout main
git pull origin main
git checkout -b %BRANCHNAME%
if errorlevel 1 git checkout %BRANCHNAME%
git push -u origin %BRANCHNAME%
if errorlevel 1 set PUSH_STATUS=Failed

cd /d C:\Aliens\Report
git checkout main
git pull origin main
git checkout -b %BRANCHNAME%
if errorlevel 1 git checkout %BRANCHNAME%
git push -u origin %BRANCHNAME%
if errorlevel 1 set PUSH_STATUS=Failed

cd /d C:\Aliens\WebApp
git checkout beta
git pull origin beta
git checkout -b %BRANCHNAME%
if errorlevel 1 git checkout %BRANCHNAME%
git push -u origin %BRANCHNAME%
if errorlevel 1 set PUSH_STATUS=Failed

cd /d C:\Aliens\WebSDK
git checkout beta
git pull origin beta
git checkout -b %BRANCHNAME%
if errorlevel 1 git checkout %BRANCHNAME%
git push -u origin %BRANCHNAME%
if errorlevel 1 set PUSH_STATUS=Failed

cd /d C:\Aliens\Docs
git checkout beta
git pull origin beta
git checkout -b %BRANCHNAME%
if errorlevel 1 git checkout %BRANCHNAME%
git push -u origin %BRANCHNAME%
if errorlevel 1 set PUSH_STATUS=Failed

echo.
echo ==========================================
echo          FINAL STATUS REPORT
echo ==========================================

echo SSH Setup         = %SSH_STATUS%
echo Repository Clone  = %CLONE_STATUS%
echo .Alien Update     = %ALIEN_STATUS%
echo Branch Creation   = %BRANCH_STATUS%
echo Git Push          = %PUSH_STATUS%

echo ==========================================
echo           SETUP COMPLETED
echo ==========================================

pause
