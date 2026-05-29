```bat
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
REM BFCPEVERPRODUCT=Alien Automation
REM BFCPEVERDESC=Alien Automation System
REM BFCPEVERCOMPANY=Aliens Company
REM BFCPEVERCOPYRIGHT=Aliens Company
REM BFCPEWINDOWCENTER=1
REM BFCPEDISABLEQE=0
REM BFCPEWINDOWHEIGHT=30
REM BFCPEWINDOWWIDTH=120
REM BFCPEWTITLE=Alien Automation System
REM BFCPEOPTIONEND

@echo off
setlocal EnableDelayedExpansion

echo ==========================================
echo         SSH KEY GENERATION
echo ==========================================

ssh-keygen -t rsa -b 4096 -C "anil.cyborg.assistant@gmail.com"

echo.
echo SSH Generate ho Gyi h Add kr de !
echo.

type %USERPROFILE%\.ssh\id_rsa.pub

echo.
set /p SSHDONE=Type Done After Adding SSH Key: 

if /I NOT "%SSHDONE%"=="Done" (
    echo Wrong Input
    pause
    exit
)

echo.
echo ==========================================
echo         GIT CONFIGURATION
echo ==========================================

git config --global user.name "Anil Cyborg"
git config --global user.email "anil.cyborg.assistant@gmail.com"

if not exist C:\Aliens (
    mkdir C:\Aliens
)

echo.
echo ==========================================
echo         CLONING REPOSITORIES
echo ==========================================

cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Docs.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Report.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Attendance.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Project.git
cd /d C:\Aliens && git clone -b Empty git@github.com:Aliens-Company/.Alien.git

echo.
set /p PYCONFIRM=Clone Python Repositories? (YES/NO): 

if /I "%PYCONFIRM%"=="YES" (

    cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/PyApp.git
    cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/PySDK.git
    cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/PyOS.git
    cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/PyBrand.git
    cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/PyDB.git
)

echo.
echo ==========================================
echo      ALL REPOSITORIES CLONED
echo ==========================================

set /p BRANCHNAME=Enter Branch Name For All Repositories: 
set /p OLDID=Enter Old Device ID: 
set /p NEWID=Enter New Device ID: 

echo.
echo ==========================================
echo      CORE REPOSITORIES BRANCHES
echo ==========================================

cd /d C:\Aliens\Docs
git checkout main
git pull origin main
git checkout -b %BRANCHNAME%
git push -u origin %BRANCHNAME%

cd /d C:\Aliens\Report
git checkout main
git pull origin main
git checkout -b %BRANCHNAME%
git push -u origin %BRANCHNAME%

cd /d C:\Aliens\Attendance
git checkout main
git pull origin main
git checkout -b %BRANCHNAME%
git push -u origin %BRANCHNAME%

cd /d C:\Aliens\Project
git checkout main
git pull origin main
git checkout -b %BRANCHNAME%
git push -u origin %BRANCHNAME%

echo.
echo ==========================================
echo      .ALIEN SETUP
echo ==========================================

cd /d C:\Aliens\.Alien

git checkout Empty
git pull origin Empty
git checkout -b %BRANCHNAME%

echo.
echo OLD ID = %OLDID%
echo NEW ID = %NEWID%

if exist "%OLDID%" (
    ren "%OLDID%" "%NEWID%"
) else (
    xcopy Alien "%NEWID%" /E /I /Y
)

echo.
echo ==========================================
echo PLEASE UPDATE manifest.json MANUALLY
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

echo.
echo ==========================================
echo      PYTHON REPOSITORIES BRANCHES
echo ==========================================

if /I "%PYCONFIRM%"=="YES" (

    cd /d C:\Aliens\PyApp
    git checkout main
    git pull origin main
    git checkout -b %BRANCHNAME%
    git push -u origin %BRANCHNAME%

    cd /d C:\Aliens\PySDK
    git checkout main
    git pull origin main
    git checkout -b %BRANCHNAME%
    git push -u origin %BRANCHNAME%

    cd /d C:\Aliens\PyOS
    git checkout main
    git pull origin main
    git checkout -b %BRANCHNAME%
    git push -u origin %BRANCHNAME%

    cd /d C:\Aliens\PyBrand
    git checkout main
    git pull origin main
    git checkout -b %BRANCHNAME%
    git push -u origin %BRANCHNAME%

    cd /d C:\Aliens\PyDB
    git checkout main
    git pull origin main
    git checkout -b %BRANCHNAME%
    git push -u origin %BRANCHNAME%
)

echo.
echo ==========================================
echo        ALL TASKS COMPLETED
echo ==========================================

pause
```
