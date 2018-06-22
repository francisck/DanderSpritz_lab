<#  
    .SYNOPSIS  
    Creates the "windomain.local" domain 

    .DESCRIPTION  
    Author: StefanScherer (https://github.com/StefanScherer/adfs2)
    Modified by: Francisco Donoso (@francisckrs)
    License: MIT  

    Creates the windomain.local domain on a Windows Server 2008 R2 server

    .NOTES 
#>


if ((gwmi win32_computersystem).partofdomain -eq $false) {

  Write-Host 'Installing RSAT tools'
  Import-Module ServerManager
  Add-WindowsFeature RSAT-AD-PowerShell,RSAT-AD-AdminCenter

  Write-Host 'Creating domain controller'

  # Disable password complexity policy
  secedit /export /cfg C:\secpol.cfg
  (gc C:\secpol.cfg).replace("PasswordComplexity = 1", "PasswordComplexity = 0") | Out-File C:\secpol.cfg
  secedit /configure /db C:\Windows\security\local.sdb /cfg C:\secpol.cfg /areas SECURITYPOLICY
  rm -force C:\secpol.cfg -confirm:$false

  # Set administrator password
  $computerName = $env:COMPUTERNAME
  $adminPassword = "vagrant"
  $adminUser = [ADSI] "WinNT://$computerName/Administrator,User"
  $adminUser.SetPassword($adminPassword)

  $PlainPassword = "vagrant" # "P@ssw0rd"
  $SecurePassword = $PlainPassword | ConvertTo-SecureString -AsPlainText -Force

  # Modified to work on Windows Server 2008 R2 
  Write-Host "Installing AD Domain Services Feature"
  Add-WindowsFeature AD-domain-services
  Write-Host "[**INFO**] Running DCPROMO now"
  Start-Process -FilePath "dcpromo" -ArgumentList "/unattend:C:\Windows\Temp\dcpromo_answer.txt" -Wait

  # WinRM stuff is necessary after the Creation of Domain since it kills it for some reason
  Write-Host "Reconfiguring WinRM"
  winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="800"}'
  winrm set winrm/config/service '@{AllowUnencrypted="true"}'
  winrm set winrm/config/service/auth '@{Basic="true"}'
  winrm set winrm/config/client/auth '@{Basic="true"}'
}