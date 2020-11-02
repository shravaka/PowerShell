#!/bin/pwsh

$username = $args[0]

#Authenticate + create new remote session
$User = "xxx"
$Passfile = "\path\to\file"
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, (Get-Content $Passfile | ConvertTo-SecureString)
$S = New-PSSession -ComputerName "NAME" -Credential $Credential -Authentication Negotiate

#Authenticat to the cloud from remote session
Invoke-Command -Session $s -ScriptBlock {$Passfile2 = "\path\to\file"}
Invoke-Command -Session $s -ScriptBlock {$Creds = New-Object System.Management.Automation.PSCredential ("$User", Get-Content $Passfile2 | ConverTo-SecureString) }
Invoke-Command -Session $s -ScriptBlock {$User2 = $using:username}
Invoke-Command -Session $s -ScriptBlock {Connect-MSolService -Credential $Creds}

#get userinfo
$user = Invoke-command -Session $s -ScriptBlock {Get-MsolUser -UserPrincipalName $user@domain | SELECT -ExpandProperty StrongAuthenticationUserDetails}

#compare Atribute
if ($user.Atribute -ne $null) {
    echo $user.Atribute
} elseif ($user.Atribute2 -ne $null) {
    echo $user.Atribute2  
} else {
    echo "missing"
}
 
#email address
echo $User2.Email

#remote sessions close
Remove-PSSession $s
