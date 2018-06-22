<#  
    .SYNOPSIS  
    Re-enable auto-logon for the Vagrant user

    .DESCRIPTION  
    Author: Francisco Donoso (@francisckrs)
    License: MIT

#>

Set-StrictMode -Version Latest

$WIN_LOGON = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

Try 
{
    # Set required registry keys to enable auto-logon as "vagrant"
    Set-ItemProperty -Path $WIN_LOGON -Name "DefaultPassword" -Value "vagrant"
    Set-ItemProperty -Path $WIN_LOGON -Name "AutoAdminLogon" -Value 1
}
Catch 
{
    Write-Host "Failed to enable auto-logon"  
    Exit 1
}