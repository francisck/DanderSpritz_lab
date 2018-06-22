Set-StrictMode -Version Latest

$WindowsUpdatePath = "HKLM:SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\"
$AutoUpdatePath = "HKLM:SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"


Try 
{
    set-service wuauserv -startup disabled
    stop-service wuauserv
    Push-Location
    Set-Location HKLM:
    New-Item -Path .\Software\Policies\Microsoft\Windows\WindowsUpdate\
    New-Item -Path .\Software\Policies\Microsoft\Windows\WindowsUpdate\AU
    Pop-Location
    Set-ItemProperty -Path $AutoUpdatePath -Name NoAutoUpdate -Value 1
}
Catch 
{
    Write-Host "Unable to disable Windows 10 updates"  
    Exit 1
}