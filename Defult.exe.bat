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

mkdir C:\Automation

echo Enabling Dark Theme...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f

echo Setting Solid Black Background...
reg add "HKCU\Control Panel\Colors" /v Background /t REG_SZ /d "0 0 0" /f
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" /v BackgroundType /t REG_DWORD /d 1 /f

powershell -command "Add-Type -TypeDefinition 'using System;using System.Runtime.InteropServices;public class W{[DllImport(\"user32.dll\")]public static extern bool SystemParametersInfo(int uAction,int uParam,string lpvParam,int fuWinIni);}'; [W]::SystemParametersInfo(20,0,'',3)"

echo.
set /p NEWPCNAME=Enter New PC Name:
wmic computersystem where name="%computername%" call rename name="%NEWPCNAME%"

echo Showing user list...
net user

echo Showing Administrator details...
net user administrator

echo Changing Administrator Password...
net user administrator *

echo Downloading VS Code...
curl -L -o C:\Automation\vscode.exe https://update.code.visualstudio.com/latest/win32-x64-user/insider

echo Installing VS Code...
start /wait C:\Automation\vscode.exe /silent

timeout /t 25 /nobreak

echo Installing Aliens Theme...
call "%LocalAppData%\Programs\Microsoft VS Code Insiders\bin\code-insiders.cmd" --install-extension HimanshuNayak.aliens-themes

timeout /t 10 /nobreak

echo Opening VS Code First Time...
start "" "%LocalAppData%\Programs\Microsoft VS Code Insiders\Code - Insiders.exe"

timeout /t 15 /nobreak

taskkill /f /im "Code - Insiders.exe"

echo Applying Aliens Theme...

if not exist "%APPDATA%\Code - Insiders\User" mkdir "%APPDATA%\Code - Insiders\User"

(
echo {
echo   "workbench.colorTheme": "Dark ( Aliens Theme )"
echo }
) > "%APPDATA%\Code - Insiders\User\settings.json"
