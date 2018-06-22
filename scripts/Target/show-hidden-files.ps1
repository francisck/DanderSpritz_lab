<#  
    .SYNOPSIS  
    Enable the setting to view hidden files and folders for the Windows 7 target machine

    .DESCRIPTION  
    Author: Francisco Donoso (@francisckrs)
    License: MIT

#>

Set-StrictMode -Version Latest

$Explorer = "HKCU:\\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

Try 
{
    # Set required registry keys to show hidden files and folders
    Set-ItemProperty -Path $Explorer -Name "Hidden" -Value 1 -Type DWord
    Set-ItemProperty -Path $Explorer -Name "ShowSuperHidden" -Value 1 -Type DWord
    cmd /c taskkill /im explorer.exe /f
    cmd /c start explorer.exe
}
Catch 
{
    Write-Host "Failed to show hidden files and folders"  
    Exit 1
}