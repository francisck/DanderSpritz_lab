<#  
    .SYNOPSIS  
    Joins the Windows 7 target to the windomain.local domain 


    .DESCRIPTION  
    Author: StefanScherer (https://github.com/StefanScherer/adfs2)
    Modified By: Francisco Donoso (@Francisckrs)

    Joins the Windows 7 target to the windomain.local domain 

    .NOTES 
#>

Write-Host 'Sleeping to give the Vagrant system time to bring up the secondary adapter'
sleep 180

if ((gwmi win32_computersystem).partofdomain -eq $false) {

    Write-Host "First, set DNS to DC to join the domain"
    $newDNSServers = "192.168.40.2"
    $adapters = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.IPAddress -match "192.168.40."}
    $adapters | ForEach-Object {$_.SetDNSServerSearchOrder($newDNSServers)}

    sleep 60

    Write-Host "Now join the domain"
    $hostname = $(hostname)
    $user = "windomain.local\vagrant"
    $pass = ConvertTo-SecureString "vagrant" -AsPlainText -Force
    $DomainCred = New-Object System.Management.Automation.PSCredential $user, $pass

    # Place the computer in the correct OU
    Write-Host "Adding Win7-target to the domain. Sometimes this step times out. If that happens, just run 'vagrant reload target --provision'" #debug
    Add-Computer -DomainName "windomain.local" -credential $DomainCred -OUPath "ou=Workstations,dc=windomain,dc=local"

    Try 
    {
        # Running slmgr rearm just in case 
        Start-Process -FilePath "slmgr" -ArgumentList "-rearm"
    }
    Catch 
    {
        Write-Host "Failed to run License Manager Rearm" 
    }


}