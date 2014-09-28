# Import PSReadline
Import-Module PSReadLine

Set-PSReadLineOption -HistorySearchCursorMovesToEnd 
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadlineKeyHandler -Chord 'Ctrl+D,Ctrl+C' -Function CaptureScreen

# Register Ctrl-D exit command
Invoke-Expression "function $([char]4) { exit }"

# Load Jump-Location profile
Import-Module 'Jump-Location\Jump.Location.psd1'

# Export Go environment variables
$env:GOPATH = "C:\Work\go"
$env:PATH += ";C:\Work\go\bin"

# Load posh-git example profile
#. 'C:\Users\Scott\Documents\WindowsPowerShell\modules\posh-git\profile.example.ps1'
. '.\Documents\WindowsPowerShell\modules\posh-git\profile.example.ps1'


