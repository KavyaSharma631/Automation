@echo off

mkdir C:\Automation

echo Enabling Dark Theme...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f

echo Disabling Transparency Effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f

taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

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

echo Installing Python...
winget install --id Python.Python.3.12 -e --source winget
echo Python installation completed.


echo.
echo ========================================
echo Downloading Tailscale for Windows...
echo ========================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "$url='https://pkgs.tailscale.com/stable/tailscale-setup-latest.exe'; $out='C:\Automation\tailscale-setup.exe'; Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing"

if exist "C:\Automation\tailscale-setup.exe" (
    echo Tailscale downloaded successfully.
    echo Installing Tailscale...
    start /wait "" "C:\Automation\tailscale-setup.exe" /quiet
    echo Tailscale installation completed.
) else (
    echo ERROR: Tailscale download failed.
)

echo.

echo Downloading VS Code...
curl -L -o C:\Automation\vscode.exe https://update.code.visualstudio.com/latest/win32-x64-user/insider

echo Installing VS Code...
start /wait C:\Automation\vscode.exe /silent

timeout /t 25 /nobreak

echo Installing Aliens Theme...
call "%LocalAppData%\Programs\Microsoft VS Code Insiders\bin\code-insiders.cmd" --install-extension HimanshuNayak.theme-Aliens

timeout /t 15 /nobreak

echo Opening VS Code...
start "" "%LocalAppData%\Programs\Microsoft VS Code Insiders\Code - Insiders.exe"

timeout /t 20 /nobreak

taskkill /f /im "Code - Insiders.exe"

echo Applying Dark Aliens Theme...

if not exist "%APPDATA%\Code - Insiders\User" mkdir "%APPDATA%\Code - Insiders\User"

(
echo {
echo   "workbench.colorTheme": "Dark ( Aliens Theme )"
echo }
) > "%APPDATA%\Code - Insiders\User\settings.json"

timeout /t 5 /nobreak

taskkill /f /im "Code - Insiders.exe"
start "" "%LocalAppData%\Programs\Microsoft VS Code Insiders\Code - Insiders.exe"
