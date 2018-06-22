<#  
    .SYNOPSIS  
    Configures the GPO to forward WEF events to the Windows Domain Controller

    .DESCRIPTION  
    Author: Chris Long (@Centurion)
    Modified By: Francisco Donoso (@Francisckrs)

    Installs the GPOs needed to specify a Windows Event Collector and makes certain event channels readable by Event Logger

    .NOTES 
#>

Write-Host "Importing the GPO to specify the WEF collector"

$GPOName = 'Windows Event Forwarding Server'
Import-GPO -BackupGpoName $GPOName -Path "c:\vagrant\scripts\resources\wef_configuration" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null
#import the Windows Event Forwarding Server config to Workstations
$OU = "ou=Workstations,dc=windomain,dc=local"
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

#Link the Windows Event Forwarding Server config to Domain Controllers
$OU = "ou=Domain Controllers,dc=windomain,dc=local"
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


Write-Host "Importing the GPO to modify ACLs on Custom Event Channels"

$GPOName = 'Custom Event Channel Permissions'
Import-GPO -BackupGpoName $GPOName -Path "c:\vagrant\scripts\resources\wef_configuration" -TargetName $GPOName -CreateIfNeeded
$gpLinks = $null

#Link the Windows Event Channels Permissions to Domain Controllers 
$OU = "ou=Domain Controllers,dc=windomain,dc=local"
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

#Link the Windows Event Channels Permissions to Workstations 

$OU = "ou=Workstations,dc=windomain,dc=local" 
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