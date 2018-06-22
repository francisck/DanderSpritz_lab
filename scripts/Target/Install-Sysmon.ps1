<#  
    .SYNOPSIS  
    Install Sysmon on the Windows 7 target with the SwiftOnSecurity Sysmon config


    .DESCRIPTION  
    Author: Francisco Donoso (@Francisckrs)

    Install Sysmon on the Windows 7 target with the SwiftOnSecurity Sysmon config

    .NOTES 
#>

Write-Host 'Installing Sysmon with the SwiftOnSecurity config..'

Try 
{
    # Set required registry keys to enable auto-logon to the Windows Domain
    Start-Process -FilePath "C:\ProgramData\chocolatey\lib\sysinternals\tools\Sysmon64.exe" -ArgumentList "-accepteula", "-i", "C:\vagrant\scripts\resources\sysmon\sysmonconfig-export.xml" -Wait
}
Catch 
{
    Write-Host "Failed to install sysmon"  
    Exit 1
}
