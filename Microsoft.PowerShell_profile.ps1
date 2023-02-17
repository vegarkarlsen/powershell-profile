### PowerShell template profile 
### Version 1.00 - Vegar Karlsen 
### 
### Code is nspired by Tim Sneath <tim@sneath.org>
### From https://gist.github.com/timsneath/19867b12eee7fd5af2ba
###
### This file should be stored in $PROFILE.CurrentUserAllHosts
### If $PROFILE.CurrentUserAllHosts doesn't exist, you can make one with the following:
###    PS> New-Item $PROFILE.CurrentUserAllHosts -ItemType File -Force
### This will create the file and the containing subdirectory if it doesn't already 
###
### As a reminder, to enable unsigned script execution of local scripts on client Windows, 
### you need to run this line (or similar) from an elevated PowerShell prompt:
###   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
### This is the default policy on Windows Server 2012 R2 and above for server Windows. For 
### more information about execution policies, run Get-Help about_Execution_Policies.
###
### ----------------------------------------------------------------------------------------

## clear console on startup
Clear-Host

## settings
# diable (venv) on virtualenv activation
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Import Terminal Icons
Import-Module -Name Terminal-Icons

# If so and the current host is a command line, then change to red color 
# as warning to user that they are operating in an elevated context
# Useful shortcuts for traversing directories
function cd... { Set-Location ..\.. }
function cd.... { Set-Location ..\..\.. }

# Compute file hashes - useful for checking successful downloads 
function md5 { Get-FileHash -Algorithm MD5 $args }
function sha1 { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }

# Quick shortcut to start notepad
function n { notepad $args }

# Drive shortcuts
function Env: { Set-Location Env: }

# Creates drive shortcut for Work Folders, if current user account is using it
# if (Test-Path "$env:USERPROFILE\Work Folders") {
#     New-PSDrive -Name Work -PSProvider FileSystem -Root "$env:USERPROFILE\Work Folders" -Description "Work Folders"
#     function Work: { Set-Location Work: }
# }


# Does the the rough equivalent of dir /s /b. For example, dirs *.png is dir /s /b *.png
function dirs {
    if ($args.Count -gt 0) {
        Get-ChildItem -Recurse -Include "$args" | Foreach-Object FullName
    } else {
        Get-ChildItem -Recurse | Foreach-Object FullName
    }
}


# Make it easy to edit this profile once it's installed
function Edit-Profile {
    if ($host.Name -match "ise") {
        $psISE.CurrentPowerShellTab.Files.Add($profile.CurrentUserAllHosts)
    } else {
        notepad $profile.CurrentUserAllHosts
    }
}


Function Test-CommandExists {
    Param ($command)
    $oldPreference = $ErrorActionPreference
    $ErrorActionPreference = 'SilentlyContinue'
    try { if (Get-Command $command) { RETURN $true } }
    Catch { Write-Host "$command does not exist"; RETURN $false }
    Finally { $ErrorActionPreference = $oldPreference }
} 


# --------------------
# Aliases
# --------------------

function ll { Get-ChildItem -Path $pwd -File }

function gcom {
    git add .
    git commit -m "$args"
}
function lazyg {
    git add .
    git commit -m "$args"
    git push
}

function Get-PubIP {
    (Invoke-WebRequest http://ifconfig.me/ip ).Content
}

function uptime {
    #Windows Powershell    
    Get-WmiObject win32_operatingsystem | Select-Object csname, @{
        LABEL      = 'LastBootUpTime';
        EXPRESSION = { $_.ConverttoDateTime($_.lastbootuptime) }
    }

        
}

# function reload-profile {
#     & $PROFILE
# }

function Find-File($name) {
    Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        $place_path = $_.directory
        Write-Output "${place_path}\${_}"
    }
}
# function unzip ($file) {
#     Write-Output("Extracting", $file, "to", $pwd)
#     $fullFile = Get-ChildItem -Path $pwd -Filter .\cove.zip | ForEach-Object { $_.FullName }
#     Expand-Archive -Path $fullFile -DestinationPath $pwd
# }


# FIXME: does not work
function unzip ($file, $out_name = $file){
    $fullfile = Get-ChildItem 
    Write-Output($fullfile)

    # Write-Output("Extracting", $pwd + $file, "to", $pwd + $outname)
}




# FIXME: should output some lines before and after
function grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
}


function touch($file) {
    "" | Out-File $file -Encoding ASCII
}
function df {
    get-volume
}


function sed($file, $find, $replace) {
    (Get-Content $file).replace("$find", $replace) | Set-Content $file
}
function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}
function export($name, $value) {
    set-item -force -path "env:$name" -value $value;
}
function pkill($name) {
    Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}
function pgrep($name) {
    try { Get-Process $name -ErrorAction "SilentlyContinue" }
    catch { Write-Host "Prosess $name does not exist" } 
}
function vimconfig { 
    vim C:\tools\vim\_vimrc 
}
function poweroff {
    shutdown /s 
}
function reboot {
    shutdown /r 
}
function home {
    Set-Location "C:\Users\$env:USERNAME\"
}

# This is to import log to cpp assigments
$cpp_log_path = "c:\$env:HOMEPATH\home\school\cpp_TDT4102\log_cpp\log.h"
function cpp_log{
    Copy-Item -Path $cpp_log_path -Destination $pwd
}

Set-Alias activate .\venv\Scripts\activate.ps1 

Set-Alias sudo gsudo 

Set-Alias e explorer.exe 

## Final Line to set prompt
oh-my-posh init pwsh --config "C:\Users\$env:USERNAME\Documents\WindowsPowerShell\powershell-profile\custom_posh_themes\iterm2.omp.json" | Invoke-Expression

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}
