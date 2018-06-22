<#  
	.SYNOPSIS  
	Installs Git from the Internet via Chocolatey. 

	.DESCRIPTION  
	Author: Francisco Donoso (@francisckrs)
	License: MIT  

	Performs a standard chocolatey installation of the most recent stable version of Git. 

	.NOTES 
#>
 
Set-StrictMode -Version Latest

$PackageName = "git.install"

Try 
{
	choco install $PackageName -y	
}
Catch 
{
	Write-Host "Fatal erorr installing package $PackageName. Exiting."	
	Exit 1
}