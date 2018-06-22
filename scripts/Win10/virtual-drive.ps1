<#  
    .SYNOPSIS  
    Maps a virtual drive (D:) with the contents of the EQtools folder

    .DESCRIPTION  
    Author: Francisco Donoso (@francisckrs)
    License: MIT

#>

Set-StrictMode -Version Latest

$RUN_KEY = "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Run"

Try 
{
    Set-ItemProperty -Path $RUN_KEY -Name "D Drive" -Value "subst D: C:\Users\vagrant\eqtools\windows"
}
Catch 
{
    Write-Host "Unable to mount virtual D: drive"  
    Exit 1
}