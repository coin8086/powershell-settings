# Autocomplete git command
# See https://github.com/dahlbyk/posh-git
# Install the module by
# PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force

Import-Module posh-git

function gs {
    git status $($args -join ' ')
}

function gc {
    git commit $($args -join ' ')
}

function gb {
    git branch $($args -join ' ')
}

# Autocomplete dotnet command
# See https://learn.microsoft.com/en-us/dotnet/core/tools/enable-tab-autocomplete#powershell

Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        dotnet complete --position $cursorPosition "$commandAst" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

Set-Alias -Name dotnet -Value dotnet.exe

# Autocomplete docker command
# See https://github.com/matt9ucci/DockerCompletion
# Install-Module DockerCompletion -Scope CurrentUser

Import-Module DockerCompletion

Set-Alias -Name docker -Value docker.exe

# Autocomplete kubectl command
# kubectl completion powershell | Out-String | Invoke-Expression
# . "$PSScriptRoot\kubectl.completion.ps1"
