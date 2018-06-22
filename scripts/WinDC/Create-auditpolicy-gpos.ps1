<#  
    .SYNOPSIS  
    Configures the GPOs for the custom Windows Event Log Audit Policy :) 

    .DESCRIPTION  
    Author: Chris Long (@Centurion)
    Modified By: Francisco Donoso (@Francisckrs)

    Installs the GPOs for the custom WinEventLog auditing policy.

    .NOTES 
#>

#Import the GPO that was backed up
Write-Host "Configuring auditing policy GPOS..."
$GPOName = 'Domain Controllers Enhanced Auditing Policy'

Import-GPO -BackupGpoName $GPOName -Path "c:\vagrant\scripts\resources\Domain_Controllers_Enhanced_Auditing_Policy" -TargetName $GPOName -CreateIfNeeded

#links the GPO to the Domain Controllers OU
$OU = "ou=Domain Controllers,dc=windomain,dc=local"
Write-Host "Importing $GPOName..."
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}

#Imports and links the GPO to the Servers OU
$GPOName = 'Servers Enhanced Auditing Policy'
$OU = "ou=Servers,dc=windomain,dc=local"
Write-Host "Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "c:\vagrant\scripts\resources\Servers_Enhanced_Auditing_Policy" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}

#Imports and links the GPO to the Workstations OU
$GPOName = 'Workstations Enhanced Auditing Policy'
$OU = "ou=Workstations,dc=windomain,dc=local" 
Write-Host "Importing $GPOName..."
Import-GPO -BackupGpoName $GPOName -Path "c:\vagrant\scripts\resources\Workstations_Enhanced_Auditing_Policy" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
$gPLinks = Get-ADOrganizationalUnit -Identity $OU -Properties name,distinguishedName, gPLink, gPOptions
$GPO = Get-GPO -Name $GPOName
If ($gPLinks.LinkedGroupPolicyObjects -notcontains $gpo.path)
{
    New-GPLink -Name $GPOName -Target $OU -Enforced yes
}
else
{
    Write-Host "GpLink $GPOName already linked on $OU. Moving On."
}

gpupdate /force