

# ## Skip if not admin
New-Item -Path "$env:HOMEPATH/Documents/WindowsPowerShell/profile.ps1" -ItemType SymbolicLink -Value "$env:HOMEPATH/Documents/WindowsPowerShell/powershell-profile/profile.ps1"
#
# # Install oh-my-posh
winget install JanDeDobbeleer.OhMyPosh
#
# # Install Terminal-Icons
Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser

