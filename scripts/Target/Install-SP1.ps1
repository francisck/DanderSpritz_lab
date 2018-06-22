<#  
    .SYNOPSIS  
    Installs Windows 7 SP1 from the internet. 

    .DESCRIPTION  
    Author: Francisco Donoso (@francisckrs)
    License: MIT  

    Performs the installation of Windows 7 SP1 from The internet. 

    .NOTES 
#>

Set-StrictMode -Version Latest


Try 
{
    (New-Object System.Net.WebClient).DownloadFile('https://download.microsoft.com/download/0/A/F/0AFB5316-3062-494A-AB78-7FB0D4461357/windows6.1-KB976932-X64.exe', 'C:\Windows\Temp\KB976932-X64.exe')
    Write-Host "Succesfully downloaded SP1. Starting installation. Hang on, this will take a long time"
    
    Start-Process -FilePath "C:\Windows\Temp\KB976932-X64.exe" -ArgumentList "/quiet", "/nodialog", "/norestart" -Wait
}
Catch 
{
    Write-Host "Fatal erorr installing Service Pack 1. Exiting."
    Write-Host $_.Exception | format-list -force  
    Exit 1
}
