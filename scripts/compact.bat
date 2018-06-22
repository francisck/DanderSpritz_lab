net stop wuauserv
rmdir /S /Q C:\Windows\SoftwareDistribution\Download
mkdir C:\Windows\SoftwareDistribution\Download
net start wuauserv
