<#  
    .SYNOPSIS  
    Installs Dotnet 4.5 redistributable from the Internet via Chocolatey (FLARE). 

    .DESCRIPTION  
    Author: Dane Stuckey (@cryps1s)
    Modified by: Francisco Donoso (@francisckrs)
    License: MIT  

    Performs a standard chocolatey installation of dotnet4.5. 

    .NOTES 
#>

Set-StrictMode -Version Latest

[String]$PackageName = "dotnet4.5"
[Int]$RetryCounter = 0
[Int]$RetryMax = 3 
[Int]$SleepCounter = 30

Try
{
    Do
    {
        # Try to Install Package
        $Process = Start-Process -FilePath "choco.exe" -ArgumentList "install","$PackageName","--limit-output","--skip-virus","-y" -NoNewWindow -PassThru -Wait 
        
        # If not a successful exit code, retry
        If ($Process.ExitCode -ne 0)
        {
            $RetryCounter += 1 
            Write-Host "[!] Failed to install package $PackageName. Attempt $RetryCounter out of $RetryMax. Sleeping for $SleepCounter seconds before next retry."
            Start-Sleep -Seconds $SleepCounter
        }
    } Until (($Process.ExitCode -eq 0) -or ($RetryCounter -eq $RetryMax))

    If (($Process.ExitCode -ne 0))
    {
        Write-Host "[!] Failed to install $PackageName after $RetryMax attempts. Throwing fatal error and exiting."
        Write-Host $_.Exception | format-list -force
        Exit 1
    }
}
Catch
{
    Write-Host "[!] Error occurred attempting to install $PackageName. Exiting."
    Write-Host $_.Exception | format-list -force
    Exit 1
}

