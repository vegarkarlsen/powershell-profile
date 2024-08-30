### PowerShell template profile
### Version 1.01 - Vegar Karlsen
###
### Code is inspired by Tim Sneath <tim@sneath.org>
### https://gist.github.com/timsneath/19867b12eee7fd5af2ba
###
### As a reminder, to enable unsigned script execution of local scripts on client Windows,
### you need to run this line (or similar) from an elevated PowerShell prompt:
###   Set-ExecutionPolicy -ExecutionPolicy Bypass
### This is the default policy on Windows Server 2012 R2 and above for server Windows. For
### more information about execution policies, run Get-Help about_Execution_Policies.
###
### ----------------------------------------------------------------------------------------

# clear console on startup
#Clear-Host

# ------------------------------------------------------------------------------------------
#   SETTINGS
# ------------------------------------------------------------------------------------------
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1                         # disable python (venv) prompt
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete    # get autocomplete menu on tab


# ------------------------------------------------------------------------------------------
#   Import Modules
# ------------------------------------------------------------------------------------------
Import-Module -Name Terminal-Icons


# ------------------------------------------------------------------------------------------
#   Soruce config files
# ------------------------------------------------------------------------------------------
$profile_folder = "$env:HOMEPATH/Documents/WindowsPowerShell/powershell-profile"

. "$profile_folder/env.ps1"
. "$profile_folder/aliases.ps1"


# ------------------------------------------------------------------------------------------
#   Load prompt
# ------------------------------------------------------------------------------------------
oh-my-posh init pwsh --config "$profile_folder\custom_posh_themes\iterm2.omp.json" | Invoke-Expression

