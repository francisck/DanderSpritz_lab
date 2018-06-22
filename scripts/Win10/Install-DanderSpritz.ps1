<#  
    .SYNOPSIS  
    Install DanderSpritz and Fuzzbunch

    .DESCRIPTION  
    Author: Francisco Donoso (@francisckrs)
    License: MIT

#>

Set-StrictMode -Version Latest


Try 
{
	#Try to clone the git repo into eqtools
    git clone https://github.com/x0rz/EQGRP_Lost_in_Translation.git C:\Users\vagrant\eqtools
}
Catch 
{
    Write-Host "Failed to clone EQ tools repo...exiting"  
    Exit 1
}

Try 
{
	#Create files and directories needed that are not in the repo
    echo $null >> C:\Users\vagrant\eqtools\windows\DSZOpsDisk-1.zip

    mkdir C:\Users\vagrant\eqtools\windows\listeningposts
}
Catch 
{
    Write-Host "Failed to create directories required for DanderSpritz and Fuzzbunch...exiting"  
    Exit 1
}

Try 
{
	# Allow the DanderSpritz javaw exe through the firewall
    netsh advfirewall firewall add rule name="DSZ in" dir=in action=allow program="C:\windows\syswow64\javaw.exe" enable=yes
}
Catch 
{
    Write-Host "Failed to create inbound DSZ firewall rule"  
}
