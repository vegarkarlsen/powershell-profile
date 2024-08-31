## Install script for Windows powershell config

$profile_folder = Split-Path $PROFILE
$powershell_config = "$profile_folder/windows-config/powershell"

# Skip if not admin
New-Item -Path "$profile_folder/profile.ps1" -ItemType SymbolicLink -Value "$powershell_config/profile.ps1" -Force

# Install oh-my-posh
winget install JanDeDobbeleer.OhMyPosh

# Install Terminal-Icons
Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser
# Install PSreadline
Install-Module -Name PSReadLine -Repository PSGallery -Scope CurrentUser


