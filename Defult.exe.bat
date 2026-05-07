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

echo Creating AlienAutomation Folder...
mkdir C:\AlienAutomation


echo Downloading VS Code...
curl -L -o C:\AlienAutomation\vscode.exe https://update.code.visualstudio.com/latest/win32-x64-user/insider

echo Installing VS Code...
C:\AlienAutomation\vscode.exe /silent


echo Enabling Dark Theme...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f

echo Setting Black Background...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f && reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f && reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "" /f && reg add "HKCU\Control Panel\Colors" /v Background /t REG_SZ /d "0 0 0" /f && RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

echo.
set /p NEWPCNAME=Enter New PC Name: 
wmic computersystem where name="%computername%" call rename name="%NEWPCNAME%"

@echo off

set /p USERNAME=Enter Username: 
set /p OLDPASS=Enter Old Password: 
set /p NEWPASS=Enter New Password: 

net use \\localhost /user:%USERNAME% %OLDPASS% >nul 2>&1

if %errorlevel%==0 (
    net user %USERNAME% %NEWPASS%
    echo Password Changed Successfully
) else (
    echo Old Password Wrong
)

pause

