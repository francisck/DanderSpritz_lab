<#  
    .SYNOPSIS  
    Sets DNS to CloudFlare and Google (rather than authorative DNS) and sets timezone to UTC

    .DESCRIPTION  
    Author: StefanScherer (https://github.com/StefanScherer/adfs2)
    Modified by: Francisco Donoso (@francisckrs)


    .NOTES 
#>

$ip = "192.168.40.2"

$subnet = $ip -replace "\.\d+$", ""

Try 
{
	$newDNSServers = "1.1.1.1", "8.8.8.8"
	$adapters = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPAddress -And ($_.IPAddress).StartsWith($subnet) }
	if ($adapters) {
	Write-Host "Setting DNS servers"
	$adapters | ForEach-Object {$_.SetDNSServerSearchOrder($newDNSServers)}
	}
}
Catch 
{
    Write-Host "Failed to set DNS to CloudFlare and Google. Not critical..."  
}

Try 
{
	Write-Host "Setting timezone to UTC"
	c:\windows\system32\tzutil.exe /s "UTC"
}
Catch 
{
    Write-Host "Failed to set timezone to UTC. Not critical..."  
}