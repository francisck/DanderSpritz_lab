<#  
	.SYNOPSIS
	Configures Windows Defender with optimal settings for malware analysis. 
	Updated: Completely disables Windows Defender so it doesn't remove EQtools 

	.DESCRIPTION
	Author: Dane Stuckey (@cryps1s)
	Modified by: Francisco Donoso (@francisckrs)
	License: MIT

	Configures Windows Defender Settings with optimal settings for malware analysis. This includes: 

	- Disable On-Access Scanning
	- Disable Scanning of Mounted/Network Shares/Drives
	- Disable Cloud Reputation and Reporting
	- Disable Response to Detected Items
	- Completely disable Windows Defender

	.NOTES 
#>

Set-StrictMode -Version Latest

Try 
{
	# Perform Hourly Signature Updates
	Set-MpPreference -SignatureUpdateInterval 1

	# Check for new Signatures before Scanning
	Set-MpPreference -CheckForSignaturesBeforeRunningScan $true

	# Enable Archive Scanning
	Set-MpPreference -DisableArchiveScanning $false 

	# Disable Behavior Monitoring
	Set-MpPreference -DisableBehaviorMonitoring $true 

	# Disable Catchup Full Scan
	Set-MpPreference -DisableCatchupFullScan $true

	# Disable Catchup Quick Scan
	Set-MpPreference -DisableCatchupQuickScan $true

	# Disable Email Scanning
	Set-MpPreference -DisableEmailScanning $true 

	# Disable IO AV Protection (e.g. Downloads)
	Set-MpPreference -DisableIOAVProtection $true 

	# Disable Intrusion Prevention System
	Set-MpPreference -DisableIntrusionPreventionSystem $true 

	# Disable Privacy Mode 
	Set-MpPreference -DisablePrivacyMode $true 

	# Disable Realtime Protection
	Set-MpPreference -DisableRealtimeMonitoring $true 

	# Disable Removable Drive Scanning
	Set-MpPreference -DisableRemovableDriveScanning $true 

	# Disable Restore Points
	Set-MpPreference -DisableRestorePoint $true 

	# Disable Mapped Drive Scans
	Set-MpPreference -DisableScanningMappedNetworkDrivesForFullScan $true 

	# Disable Scanning of Network Files
	Set-MpPreference -DisableScanningNetworkFiles $true 

	# Disable Script Scans
	Set-MpPreference -DisableScriptScanning $true
	
	# Never Submit Samples
	Set-MpPreference -SubmitSamplesConsent Never 

	# Ignore Unknown Threats 
	Set-MpPreference -UnknownThreatDefaultAction NoAction

	# Ignore Severe Threats
	Set-MpPreference -SevereThreatDefaultAction NoAction

	# Ignore High Threat 
	Set-MpPreference -HighThreatDefaultAction NoAction

	# Ignore Moderate Threats
	Set-MpPreference -ModerateThreatDefaultAction NoAction

	# Ignore Low Threat 
	Set-MpPreference -LowThreatDefaultAction NoAction

	# Disable MAPS Reporting
	Set-MpPreference -MAPSReporting Disabled

	sc stop windefend

	sc delete windefend

	$WINDEF = "HKLM:SOFTWARE\Policies\Microsoft\Windows Defender"

	Set-ItemProperty -Path $WINDEF -Name DisableAntiSpyware -Value 1
}
Catch
{
	Write-Error "Could not configure Defender settings. Exiting."
	Write-Host $_.Exception | format-list -force
	Exit 1
}
 
