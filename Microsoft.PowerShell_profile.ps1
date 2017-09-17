# Load and configure PSReadLine module
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

# Disabling ZLocation until I can figure out why it resets my
# custom prompt settings
# Load ZLocation module
# Import-Module ZLocation

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

# Disabling VsVars since .NET Core doesn't use them, and we can always
# load them manually in .NET Framework scripts that require them
# Load Visual Studio environment variables
# Import-Module Posh-VsVars

# Set-VsVars -Version 'latest'

# Load Chocolatey profile
# Import-Module -Name C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
