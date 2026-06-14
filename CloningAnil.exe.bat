@ECHO OFF
setlocal EnableDelayedExpansion

set SSH_STATUS=Failed

set DOCS_STATUS=Failed
set REPORT_STATUS=Failed
set ATTENDANCE_STATUS=Failed
set PROJECT_STATUS=Failed
set ALIEN_STATUS=Failed

set WEBSITE_STATUS=Failed
set WEBOS_STATUS=Failed
set WEBAPP_STATUS=Failed
set WEBSDK_STATUS=Failed
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

echo Generating SSH Key...
ssh-keygen -t rsa -b 4096 -C "ianilcyborg@gmail.com"

if %errorlevel%==0 (
    set SSH_STATUS=Already Done
)

echo.
echo SSH Generate ho Gyi h Add kr de !
set /p SSHDONE=Type Done After Adding SSH Key: 

if /I NOT "%SSHDONE%"=="Done" (
    echo Wrong Input
    pause
    exit
)

mkdir C:\Aliens
if not exist C:\Aliens mkdir C:\Aliens
echo Cloning Repositories...

cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/.github.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Cyborg.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Copilot.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Project.git
cd /d C:\Aliens && git clone -b beta git@github.com:Aliens-Company/Docs.git
cd C:/Aliens && git clone -b main git@github.com:Aliens-Company/Website.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Blog.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Report.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Attendance.git
cd /d C:\Aliens && git clone -b main git@github.com:Aliens-Company/Secret.git
cd /d C:\Aliens && git clone -b Empty git@github.com:Aliens-Company/.Alien.git
cd /d C:\Aliens && git clone -b beta git@github.com:Aliens-Company/WebOS.git
cd /d C:\Aliens && git clone -b beta git@github.com:Aliens-Company/WebApp.git
cd /d C:\Aliens && git clone -b beta git@github.com:Aliens-Company/WebSDK.git

echo.
echo All Repositories Cloned Successfully!

echo.
set /p BRANCHNAME=Enter Branch Name For All Repositories: 
set /p NEWID=Enter New Device ID: 

echo.
echo Creating Branches And Updating .Alien...

cd /d C:\Aliens\.Alien

set OLDID=

for /d %%i in (C*) do (
    set OLDID=%%i
)

if defined OLDID (
    call ren "%OLDID%" "%NEWID%"
) else (
    xcopy /E /I /Y Alien "%NEWID%"
)

cd /d C:\Aliens\.Alien\%NEWID%

if exist manifest.json (
    powershell -Command "(Get-Content manifest.json) -replace 'C[0-9][0-9][0-9][0-9]','%NEWID%' | Set-Content manifest.json"
)

git checkout -b %BRANCHNAME%
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

cd /d C:\Aliens\Website
git checkout main
git pull origin main
git checkout -b %BRANCHNAME%
git push -u origin %BRANCHNAME%

cd /d C:\Aliens\Report
git checkout main
git pull origin main
git checkout -b %BRANCHNAME%
git push -u origin %BRANCHNAME%

cd /d C:\Aliens\WebOS
git checkout beta
git pull origin beta
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
if exist C:\Aliens\Docs (
    set DOCS_STATUS=Already Done
)

if exist C:\Aliens\Report (
    set REPORT_STATUS=Already Done
)

if exist C:\Aliens\Attendance (
    set ATTENDANCE_STATUS=Already Done
)

if exist C:\Aliens\Project (
    set PROJECT_STATUS=Already Done
)

if exist C:\Aliens\.Alien (
    set ALIEN_STATUS=Already Done
)

if exist C:\Aliens\Website (
    set WEBSITE_STATUS=Already Done
)

if exist C:\Aliens\WebOS (
    set WEBOS_STATUS=Already Done
)

if exist C:\Aliens\WebApp (
    set WEBAPP_STATUS=Already Done
)

if exist C:\Aliens\WebSDK (
    set WEBSDK_STATUS=Already Done
)

echo.
echo ==========================================
echo         FINAL STATUS REPORT
echo ==========================================

echo SSH Setup          = !SSH_STATUS!

echo.
echo ----- CORE REPOSITORIES -----

echo Docs Repo          = !DOCS_STATUS!
echo Report Repo        = !REPORT_STATUS!
echo Attendance Repo    = !ATTENDANCE_STATUS!
echo Project Repo       = !PROJECT_STATUS!
echo .Alien Repo        = !ALIEN_STATUS!

echo.
echo ----- WEB REPOSITORIES -----

echo Website Repo       = !WEBSITE_STATUS!
echo WebOS Repo         = !WEBOS_STATUS!
echo WebApp Repo        = !WEBAPP_STATUS!
echo WebSDK Repo        = !WEBSDK_STATUS!

echo.
echo ==========================================
echo      ALL TASKS COMPLETED
echo ==========================================
pause
