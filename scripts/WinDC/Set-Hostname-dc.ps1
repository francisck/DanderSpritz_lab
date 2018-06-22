<#  
    .SYNOPSIS  
    Renames the Windows 2008 R2 instance to "dc-target" 

    .DESCRIPTION  
    Author: nitrocode (https://gist.github.com/nitrocode/845c55c84152ede8683f)
    Modified by: Francisco Donoso (@francisckrs)


    .NOTES 
#>


$name = "dc-target"

Write-Host "Changing name to:  $name"

# change hostname
$ComputerInfo = Get-WmiObject -Class Win32_ComputerSystem
$ComputerInfo.Rename($name)
