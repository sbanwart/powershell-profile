# Import PSReadline
Import-Module PSReadLine

Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadlineKeyHandler -Chord 'Ctrl+D,Ctrl+C' -Function CaptureScreen

# Register Ctrl-D exit command
Invoke-Expression "function $([char]4) { exit }"

# Load Jump-Location module
Import-Module Jump.Location

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

# Export Go environment variables
$env:GOPATH = "C:\Work\go"
$env:PATH += ";C:\Work\go\bin"

# Load Visual Studio environment variables
function Get-Batchfile ($file) {
    $cmd = "`"$file`" & set"
    cmd /c $cmd | Foreach-Object {
        $p, $v = $_.split('=')
        Set-Item -path env:$p -value $v
    }
}

function VsVars32($version = "12.0")
{
    #$key = "HKLM:SOFTWARE\Microsoft\VisualStudio\" + $version
    #$VsKey = get-ItemProperty $key
    #$VsInstallPath = [System.IO.Path]::GetDirectoryName($VsKey.InstallDir)
    #$VsToolsDir = [System.IO.Path]::GetDirectoryName($VsInstallPath)
    #$VsToolsDir = [System.IO.Path]::Combine($VsToolsDir, "Tools")
    $VsToolsDir = "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Tools"
    $BatchFile = [System.IO.Path]::Combine($VsToolsDir, "vsvars32.bat")
    Get-Batchfile $BatchFile
    [System.Console]::Title = "Visual Studio " + $version + " Windows Powershell"
    #add a call to set-consoleicon as seen below...hm...!
}

VsVars32
