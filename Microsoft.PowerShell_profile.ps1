﻿# Load and configure PSReadLine module
Import-Module PSReadLine

Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadlineKeyHandler -Chord 'Ctrl+D,Ctrl+C' -Function CaptureScreen

# Register Ctrl-D exit command
Invoke-Expression "function $([char]4) { exit }"

# Load and configure Get-ChildItemColor module
Import-Module Get-ChildItemColor

Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

# Load z module
Import-Module z

# Alias to jump to my working directory
function w { Set-Location C:\Work }

# Load posh-git module
Import-Module posh-git

# Set git prompt
function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    Write-Host($pwd.ProviderPath) -nonewline

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    return "> "
}

# Load oh-my-posh module
Import-Module oh-my-posh

# Configure oh-my-posh theme
Set-Theme Fish

# Load Chocolatey profile
Import-Module -Name C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Setup Terraform container alias
function terraform($cmd) {docker run -it hashicorp/terraform $cmd}
Set-Alias tf terraform

# Setup httpie container alias
function httpie_container() {docker run -it sbanwart/httpie:1.0 @Args}
Set-Alias httpie httpie_container

function jk_container() {docker run -it sbanwart/jk @Args}
Set-Alias jk jk_container

# Setup Visual Studio Code alias
function VsCode-CurrDir() {code .}
Set-Alias vsc VsCode-CurrDir

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
(& C:\Users\Scott\Anaconda3\Scripts\conda.exe "shell.powershell" "hook") | Out-String | Invoke-Expression
#endregion

