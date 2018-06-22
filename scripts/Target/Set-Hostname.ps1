<#  
    .SYNOPSIS  
    Renames the Windows 7 machine to "Win7Target" 

    .DESCRIPTION  
    Author: nitrocode (https://gist.github.com/nitrocode/845c55c84152ede8683f)
    Modified by: Francisco Donoso (@francisckrs)


    .NOTES 
#>


$name = "Win7Target"

Write-Host "Changing name to:  $name"

# change hostname
$ComputerInfo = Get-WmiObject -Class Win32_ComputerSystem
$ComputerInfo.Rename($name)
