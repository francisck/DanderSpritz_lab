<#  
	.SYNOPSIS  
	Downloads and installs Winpy32 2.6 required by DanderSpritz

	.DESCRIPTION  
	Author: Francisco Donoso (@francisckrs)
	License: MIT

#>

 Set-StrictMode -Version Latest

 #Use TLS 1.2 which is required by sourceforce
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;

 Try
 {
	 # Download Winpy32 from sourceforce
	(New-Object System.Net.WebClient).DownloadFile('https://jaist.dl.sourceforge.net/project/pywin32/pywin32/Build%20221/pywin32-221.win32-py2.6.exe', 'C:\Windows\Temp\pywin32-py2.6.exe')
	
	# Extract required files from exe as there is no way to launch .exe w/o a GUI
	cmd /c "C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\pywin32-py2.6.exe -oC:\Windows\Temp\winpy

	Copy-Item "C:\Windows\Temp\winpy\PLATLIB\*" -Destination "c:\Python26\Lib\site-packages" -Recurse

	Copy-Item "C:\Windows\Temp\winpy\SCRIPTS\*" -Destination "c:\Python26\Lib\site-packages" -Recurse

	#Use python to install winpy
	python C:\Python26\Lib\site-packages\pywin32_postinstall.py -install
 }
 Catch
 {
	 Write-Error "Could not install Winpy32. Exiting..."
	 Write-Host $_.Exception | format-list -force
	Exit 1
 }
