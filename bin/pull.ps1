
# pull form github and update $profile


# update $profile from repo:
 
$now = Get-Date -Format "dd_MM_yy"


$powershell_profile = "c:\$ENV:HOMEPATH\Documents\WindowsPowershell"

Get-Item -Path $PROFILE | Move-Item -Destination "$powershell_profile\powershell-profile\backup\profile_$now"


# Copy-Item -Path "$pwd\Microsoft.PowerShell_profile.ps1" -Destination $PROFILE
# Write-Host "The profile @ [$PROFILE] has been updated, and old profile have been backed up."  

