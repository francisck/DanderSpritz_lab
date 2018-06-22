<#  
    .SYNOPSIS  
    Adds the WINDOMAIN vagrant user to the local admins group and changes auto-login to the domain user account


    .DESCRIPTION  
    Author: Francisco Donoso (@Francisckrs)

    .NOTES 
#>

Try 
{
    # Add the domain vagrant user to the local admin group
    $de = [ADSI]"WinNT://Win7Target/Administrators,group" 
    $de.psbase.Invoke("Add",([ADSI]"WinNT://WINDOMAIN/vagrant").path)
}
Catch 
{
    Write-Host "Failed to add domain 'vagrant' user to local admin group. Please add the user manually"
    Write-Host $_.Exception | format-list -force  
}

$WIN_LOGON = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

Try 
{
    # Set required registry keys to enable auto-logon to the Windows Domain
    Set-ItemProperty -Path $WIN_LOGON -Name "DefaultDomainName" -Value "WINDOMAIN"
    Write-Host $_.Exception | format-list -force
}
Catch 
{
    Write-Host "Failed to enable auto-logon to the domain user"  
}
