# Aliases

Set-Alias -Name l -Value Get-ChildItem
Set-Alias -Name pd -Value Push-Location
Set-Alias -Name ppd -Value Pop-Location
Set-Alias -Name vi -Value vim
Set-Alias -Name time -Value Measure-Command

# Autocomplete git command
# See https://github.com/dahlbyk/posh-git
# Install the module by
# PowerShellGet\Install-Module posh-git [-Scope CurrentUser -Force]
if (Get-Module -Name posh-git -ListAvailable) {
    Import-Module posh-git
    $GitPromptSettings.EnableFileStatus = $false
}
else {
    Write-Warning 'posh-git is not found.'
}

function gs {
    $cmd = "git status $($args -join ' ')"
    Invoke-Expression $cmd
}

function gc_ {
    $cmd = "git commit $($args -join ' ')"
    Invoke-Expression $cmd
}

# Override predefined alias gc
# Note: The AllScope option cannot be removed from the original definition
Set-Alias -Name gc -Value gc_ -Option AllScope -Force

function gb {
    $cmd = "git branch $($args -join ' ')"
    Invoke-Expression $cmd
}

function gd {
    $cmd = "git diff -U10 $($args -join ' ')"
    Invoke-Expression $cmd
}

function gl_ {
    $cmd = "git log $($args -join ' ')"
    Invoke-Expression $cmd
}

# Override predefined alias gl
# Note: The AllScope option cannot be removed from the original definition
Set-Alias -Name gl -Value gl_ -Option AllScope -Force

function glns {
    $cmd = "git log --name-status $($args -join ' ')"
    Invoke-Expression $cmd
}

function gss {
    $cmd = "git shortlog -s --no-merges $($args -join ' ')"
    Invoke-Expression $cmd
}

function gls {
    $cmd = "git ls-files $($args -join ' ')"
    Invoke-Expression $cmd
}

# Autocomplete dotnet command
# See https://learn.microsoft.com/en-us/dotnet/core/tools/enable-tab-autocomplete#powershell
try {
    Get-Command dotnet | Out-Null
    Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
        param($wordToComplete, $commandAst, $cursorPosition)
        dotnet complete --position $cursorPosition "$commandAst" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
    }
}
catch {
    Write-Warning '.NET CLI is not found.'
}

Set-Alias -Name dotnet -Value dotnet.exe

# Autocomplete docker command
# See https://github.com/matt9ucci/DockerCompletion
# PowerShellGet\Install-Module DockerCompletion [-Scope CurrentUser]
if (Get-Module -Name DockerCompletion -ListAvailable) {
    Import-Module DockerCompletion
}
else {
    Write-Warning 'DockerCompletion is not found.'
}

Set-Alias -Name docker -Value docker.exe

# Autocomplete kubectl command
# kubectl completion powershell | Out-String | Invoke-Expression
# . "$PSScriptRoot\kubectl.completion.ps1"

