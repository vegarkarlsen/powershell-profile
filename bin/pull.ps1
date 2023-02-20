
# pull form github and update $profile


# update $profile from repo:
 
$now = Get-Date -Format "dd_MM_yy"

$powershell_profile = "c:\$ENV:HOMEPATH\Documents\WindowsPowershell"
$path_to_backup_to = "$powershell_profile\powershell-profile\backup\profile_$now"
$index = 1

if (Test-Path("$powershell_profile\powershell-profile\backup" )){
    # do nothing
}
else{
    New-Item -ItemType Directory -Path "$powershell_profile\powershell-profile\backup"
}


if( Test-Path($path_to_backup_to) ){
    while (Test-Path($path_to_backup_to)){
        $path_to_backup_to += "(" + $index + ")"
        $index++
    }
}

Get-Item -Path $PROFILE | Move-Item -Destination $path_to_backup_to
Copy-Item -Path "$powershell_profile\powershell-profile\Microsoft.PowerShell_profile.ps1" -Destination $PROFILE
Write-Host "The profile @ [$PROFILE] has been updated, and old profile have been backed up."  

