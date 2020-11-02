#!/usr/bin/pwsh

# set time period
$Start = (get-date).ToUniversalTime().AddMinutes(-10)
$End = (get-date).ToUniversalTime().AddMinutes(-5)

# authentication
$User = "xxx"
$Passfile = "\path\to\file"
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, (Get-Content $Passfile | ConvertTo-SecureString)


#connect to MSExchange and download data
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Credential -Authentication Basic -AllowRedirection
Import-PSSession -Session $Session
$Logentry = Get-MessageTrace -PageSize 5000 -StartDate $Start -EndDate $End | Export-CSV -NoTypeInformation -Append -Path "\Path\To\File"
