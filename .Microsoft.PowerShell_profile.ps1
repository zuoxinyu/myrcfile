Import-Module posh-git
#Import-Module oh-my-posh
#Import-Module PowerLine
#Import-Module DirColors
#Import-Module PSColor
Import-Module 'D:\DevEnv\vcpkg\scripts\posh-vcpkg'

#Set-Theme robbyrussell

Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
#Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
#Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-Alias ll ls
Set-Alias cd Push-Location -Option AllScope
Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias gvim nvim-qt.exe
Set-Alias which Get-Command
Set-Alias cl C:\'Program Files (x86)\Microsoft Visual Studio'\2019\Professional\VC\Tools\MSVC\14.29.30133\bin\HostX64\x64\cl.exe

function gcam() {git commit -am}
function gs() {git status}
function gl() {git log}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

Invoke-Expression (starship init powershell)
