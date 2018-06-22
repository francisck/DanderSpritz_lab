<#  
    .SYNOPSIS  
    Configures the GPO to for PowerShell logging

    .DESCRIPTION  
    Author: Chris Long (@Centurion)
    Modified By: Francisco Donoso (@Francisckrs)

    Installs the GPOs needed to configure PowerShell logging

    .NOTES 
#>

Write-Host "Importing the GPO to enable Powershell Module, ScriptBlock and Transcript logging..."

#Import the GPO from the resources folder
Import-GPO -BackupGpoName 'Powershell Logging' -Path "c:\vagrant\scripts\resources\powershell_logging" -TargetName 'Powershell Logging' -CreateIfNeeded

#link the GPO to the workstations OU
$OU = "ou=Workstations,dc=windomain,dc=local" 
$gPLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name 'Powershell Logging'
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name 'Powershell Logging' -Target $OU -Enforced yes
}
else
{
    Write-Host "Powershell Loggin was already linked at $OU. Moving On."
}

#link the GPO to the servers OU
$OU = "ou=Servers,dc=windomain,dc=local" 
$gPLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name 'Powershell Logging'
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name 'Powershell Logging' -Target $OU -Enforced yes
}
else
{
    Write-Host "Powershell Loggin was already linked at $OU. Moving On."
}

#link the GPO to the Domain Controllers OU
$OU = "ou=Domain Controllers,dc=windomain,dc=local"
$gPLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name 'Powershell Logging' -Target $OU -Enforced yes
}
else
{
    Write-Host "Powershell Loggin was already linked at $OU. Moving On."
}

gpupdate /force