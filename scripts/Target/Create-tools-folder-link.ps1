<#  
    .SYNOPSIS  
    Creates a shorcut to the "tools" folder on the local vagrant users desktop 


    .DESCRIPTION  
    Author: Francisco Donoso (@Francisckrs)

    .NOTES 
#>


Write-Host "Sleeping to give Windows a little time to catch up with vagrant"
sleep 1

Write-Host "creating the tools folder shortcut on the vagrant domain users desktop"

Try 
{

    $user = "windomain.local\vagrant"
    $pass = ConvertTo-SecureString "vagrant" -AsPlainText -Force
    $DomainCred = New-Object System.Management.Automation.PSCredential $user, $pass
    #Create a shortcut into the tools folder on vagrant domain users desktop
    Start-Process powershell.exe -Credential $DomainCred -NoNewWindow -ArgumentList "Start-Process powershell.exe -Verb runAs"
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("C:\Users\vagrant.WINDOMAIN\Desktop\tools.lnk")
    $Shortcut.TargetPath = "C:\Users\vagrant\Desktop\tools"
    $Shortcut.Save()
}
Catch 
{
    Write-Host "Failed to create shortcut for tools folder. Not critical..."
    Write-Host $_.Exception | format-list -force  
}
