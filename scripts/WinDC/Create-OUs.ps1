<#  
    .SYNOPSIS  
    Configures the necessary Organization Units in Active Directory (LDAP)

    .DESCRIPTION  
    Author: Chris Long (@Centurion)
    Modified By: Francisco Donoso (@Francisckrs)


    .NOTES 
#>

Write-Host "Creating Servers OU"
if (!([ADSI]::Exists("LDAP://OU=Servers,DC=windomain,DC=local")))
{    
    New-ADOrganizationalUnit -Name "Servers" -Server "dc-target.windomain.local"
}
else
{
    Write-Host "Servers OU already exists. Moving On."
}


Write-Host "Creating Workstations OU"
if (!([ADSI]::Exists("LDAP://OU=Workstations,DC=windomain,DC=local")))
{
    New-ADOrganizationalUnit -Name "Workstations" -Server "dc-target.windomain.local"
}
else
{
    Write-Host "Workstations OU already exists. Moving On."
}