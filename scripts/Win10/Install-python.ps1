<#  
	.SYNOPSIS  
	Downloads and installs Python 2.6 required by DanderSpritz

	.DESCRIPTION  
	Author: Francisco Donoso (@francisckrs)
	License: MIT

#>

 Set-StrictMode -Version Latest

 #Use TLS 1.2 which is required by github
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;

 Try
 {
	 # Download Python MSI from github
	(New-Object System.Net.WebClient).DownloadFile('https://github.com/numpy/numpy-vendor/raw/master/python-2.6.6.msi', 'C:\Windows\Temp\python-2.6.6.msi')
	msiexec /qn /i C:\Windows\Temp\python-2.6.6.msi /log C:\Windows\Temp\python.log

	#set the new path permantently
	setx /M PATH "$($env:path);;C:\Python26"
 }
 Catch
 {
	 Write-Error "Could not install Python 2.6. Exiting..."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }