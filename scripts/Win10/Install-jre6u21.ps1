<#  
	.SYNOPSIS  
	Downloads and installs JRE version 6u21 required for DanderSpritz

	.DESCRIPTION  
	Author: Francisco Donoso (@francisckrs)
	License: MIT

#>

 Set-StrictMode -Version Latest

 Try
 {
	 # Download JRe from public location
	(New-Object System.Net.WebClient).DownloadFile('https://ww2.chemistry.gatech.edu/software/JRE/jre-6u21-windows-i586.exe', 'C:\Windows\Temp\jre6u14.exe')
	cmd /c C:\Windows\Temp\jre6u14.exe /s
 }
 Catch
 {
	 Write-Error "Could not install JRE 6u21. Exiting..."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }