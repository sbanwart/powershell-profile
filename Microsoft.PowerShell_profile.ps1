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

# Load z module
Import-Module z

# Alias to jump to my working directory
function w { Set-Location C:\Work }

# Load Starship prompt
Invoke-Expression (&starship init powershell)

# Load posh-git module
#Import-Module posh-git

# Configure oh-my-posh theme
#Set-Theme Sorin

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
Set-Theme Sorin

# Load Chocolatey profile
Import-Module -Name C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Setup Terraform container alias
function terraform_container() {docker run --rm -it hashicorp/terraform @Args}
Set-Alias terraform terraform_container

# Setup httpie container alias
function httpie_container() {docker run --rm -it sbanwart/httpie @Args}
Set-Alias httpie httpie_container

# Setup pulumi container alias
function pulumi_container() {docker run --rm -it -v ${pwd}:/data -w /data pulumi/pulumi @Args}
Set-Alias pulumi pulumi_container

function curlie_container() {docker run --rm -it -v ${pwd}:/data -w /data sbanwart/curlie @Args}
Set-Alias curlie curlie_container

function jrnl_container() {docker run --rm -it -v ${home}:/home/data -w /home/data -e XDG_CONFIG_HOME="/home/data/.config" sbanwart/jrnl @Args}
Set-Alias jrnl jrnl_container

function diagrams_container() {docker run --rm -it -v ${pwd}:/data -w /data sbanwart/diagrams @Args}
Set-Alias diagrams diagrams_container

# Setup Visual Studio Code alias
function VsCode-CurrDir() {code .}
Set-Alias vsc VsCode-CurrDir

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
(& C:\Users\Scott\Anaconda3\Scripts\conda.exe "shell.powershell" "hook") | Out-String | Invoke-Expression
#endregion

