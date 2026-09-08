# ============================================================
# AWS EC2 WALLPAPER + WINDOWS UI CONFIGURATION
# ============================================================

$config  = "C:\ProgramData\Amazon\EC2Launch\config\agent-config.yml"
$backup  = "C:\ProgramData\Amazon\EC2Launch\config\agent-config.yml.backup"
$startup = "C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\setwallpaper.lnk"

Write-Host ""
Write-Host "========================================"
Write-Host " AWS EC2 + Windows UI Configuration"
Write-Host "========================================"
Write-Host ""


# ============================================================
# 1. BACKUP EC2LAUNCH CONFIGURATION
# ============================================================

Write-Host "[1/7] Creating EC2Launch configuration backup..."

if (Test-Path $config) {

    Copy-Item $config $backup -Force

    Write-Host "[OK] Backup created:"
    Write-Host $backup

}
else {

    Write-Host "[ERROR] agent-config.yml not found!"
    exit

}


# ============================================================
# 2. DELETE AWS WALLPAPER STARTUP SHORTCUT
# ============================================================

Write-Host ""
Write-Host "[2/7] Removing AWS setWallpaper Startup shortcut..."

if (Test-Path $startup) {

    Remove-Item $startup -Force

    Write-Host "[OK] setwallpaper.lnk deleted."

}
else {

    Write-Host "[INFO] setwallpaper.lnk not found."

}


# ============================================================
# 3. REMOVE setWallpaper TASK FROM EC2LAUNCH CONFIG
# ============================================================

Write-Host ""
Write-Host "[3/7] Removing setWallpaper task from EC2Launch..."

$lines = Get-Content $config

$result = New-Object System.Collections.Generic.List[string]

$skip = $false

foreach ($line in $lines) {

    # Start skipping when setWallpaper task is found
    if ($line -match '^\s*-\s*task:\s*setWallpaper\s*$') {

        $skip = $true

        continue
    }

    # While inside setWallpaper block
    if ($skip) {

        # Stop skipping when next task or stage starts
        if ($line -match '^\s*-\s*task:|^\s*-\s*stage:') {

            $skip = $false

            $result.Add($line)
        }
        else {

            continue
        }

    }
    else {

        $result.Add($line)
    }
}


# Write updated configuration
Set-Content -Path $config -Value $result -Encoding UTF8

Write-Host "[OK] setWallpaper task removed."


# ============================================================
# 4. VERIFY AWS WALLPAPER IS REMOVED
# ============================================================

Write-Host ""
Write-Host "[4/7] Verifying AWS wallpaper configuration..."

if (Select-String -Path $config -Pattern "setWallpaper" -Quiet) {

    Write-Host "[WARNING] setWallpaper is still present!"

}
else {

    Write-Host "[OK] setWallpaper successfully removed."

}


# Verify Startup shortcut
if (Test-Path $startup) {

    Write-Host "[WARNING] setwallpaper.lnk still exists!"

}
else {

    Write-Host "[OK] setwallpaper.lnk is removed."

}


# ============================================================
# 5. WINDOWS DARK MODE + TRANSPARENCY
# ============================================================

Write-Host ""
Write-Host "[5/7] Applying Windows Dark Mode..."

# Apps Dark Mode
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
    /v AppsUseLightTheme /t REG_DWORD /d 0 /f

# Windows/System Dark Mode
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
    /v SystemUsesLightTheme /t REG_DWORD /d 0 /f

# Disable Transparency
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
    /v EnableTransparency /t REG_DWORD /d 0 /f

Write-Host "[OK] Dark Mode enabled."
Write-Host "[OK] Transparency disabled."


# ============================================================
# 6. SOLID BLACK BACKGROUND
# ============================================================

Write-Host ""
Write-Host "[6/7] Setting Solid Black Background..."

# Windows background color = Black
reg add "HKCU\Control Panel\Colors" `
    /v Background /t REG_SZ /d "0 0 0" /f

# Remove wallpaper image
reg add "HKCU\Control Panel\Desktop" `
    /v Wallpaper /t REG_SZ /d "" /f

# Solid color background
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" `
    /v BackgroundType /t REG_DWORD /d 1 /f


# Apply black background immediately
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll")]
    public static extern bool SystemParametersInfo(
        int uAction,
        int uParam,
        string lpvParam,
        int fuWinIni
    );
}
"@

[Wallpaper]::SystemParametersInfo(20, 0, "", 3)

Write-Host "[OK] Solid Black Background applied."


# ============================================================
# 7. TASKBAR SETTINGS
# ============================================================

Write-Host ""
Write-Host "[7/7] Configuring Taskbar..."

# ------------------------------------------------------------
# Task View = OFF
# ------------------------------------------------------------

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
    /v ShowTaskViewButton /t REG_DWORD /d 0 /f

Write-Host "[OK] Task View disabled."


# ------------------------------------------------------------
# Search = Search Icon
# ------------------------------------------------------------

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" `
    /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f

Write-Host "[OK] Search changed to Search Icon."


# ============================================================
# RESTART EXPLORER
# ============================================================

Write-Host ""
Write-Host "Applying Taskbar changes..."

Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue

Start-Sleep -Seconds 2

Start-Process explorer.exe

Start-Sleep -Seconds 3


# ============================================================
# FINAL RESULT
# ============================================================

Write-Host ""
Write-Host "========================================"
Write-Host " CONFIGURATION COMPLETED"
Write-Host "========================================"
Write-Host ""
Write-Host "[OK] AWS setWallpaper disabled"
Write-Host "[OK] setwallpaper.lnk removed"
Write-Host "[OK] EC2Launch configuration updated"
Write-Host "[OK] Dark Mode enabled"
Write-Host "[OK] Transparency disabled"
Write-Host "[OK] Solid Black Background enabled"
Write-Host "[OK] Task View disabled"
Write-Host "[OK] Search Icon enabled"
Write-Host ""
Write-Host "Backup:"
Write-Host $backup
Write-Host ""
Write-Host "Please restart the server to verify everything."
Write-Host ""
