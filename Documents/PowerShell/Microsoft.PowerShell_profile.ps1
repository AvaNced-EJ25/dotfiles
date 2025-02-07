Remove-Alias -Name ls
Remove-Alias -Name cat
Remove-Alias -Name pwd

function eza-ls { eza --icons=auto --classify=auto $args }
function eza-ll { eza --long --header --icons=auto --classify=auto --git --smart-group $args }
function eza-la { eza --long --all --header --icons=auto --classify=auto --git --smart-group $args }
function eza-ltree { eza --tree --header --long --icons=auto --classify=auto --git --smart-group $args }
function eza-tree { eza --tree --icons=auto --classify=auto $args }
function cd-dl { cd "~/Downloads" }
function cd-zz { cd "-" }
function fzf-nvim { fzf --preview='bat --color=always -- {}' --bind 'enter:become(nvim {})' }
function fzf-bat { fzf --preview='bat --color=always -- {}' --bind 'enter:become(bat -- {})' }
function bin-bat { bat --nonprintable-notation caret --show-all $args }
function dot-rc {
    nvim "$HOME\.dotfiles"
    chezmoi apply
}

function reboot-func {
    if ( -not $args ) {
        $args=0
    }

    shutdown /r /t $args
}

function pwd-func {
    $out=Get-Location
    if ( $out ) {
        return $out.path
    }
    return $null
}

# Add ~/.local/bin to PATH if it exists
$local_bin="$env:HOME\.local\bin"
if ( (Test-Path $local_bin) -and (-not ($env:PATH -like "*$local_bin*") ) ) {
    $env:PATH += ";$local_bin;"
}

$env:FZF_DEFAULT_OPTS="--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 --height 40% --layout=reverse --border --info=inline"
$env:LG_CONFIG_FILE="$HOME\.config\lazygit\config.yml,$HOME\.config\lazygit\pink.yml"

New-Alias -Name vi -Value nvim
New-Alias -Name fvim -Value fzf-nvim
New-Alias -Name fbat -Value fzf-bat

New-Alias -Name dl -Value cd-dl
New-Alias -Name zz -Value cd-zz

New-Alias -Name ls -Value eza-ls
New-Alias -Name ll -Value eza-ll
New-Alias -Name la -Value eza-la
New-Alias -Name ltree -Value eza-ltree
New-Alias -Name tree -Value eza-tree

New-Alias -Name lg -Value lazygit.exe
New-Alias -Name cz -Value chezmoi.exe

New-Alias -Name cat -Value bat
New-Alias -Name binbat -Value bin-bat

New-Alias -Name sreload -value refreshenv.cmd
New-Alias -Name reboot -Value reboot-func
New-Alias -Name pwd -Value pwd-func

#New-Alias -Name more less.exe
#$env:PAGER = 'less.exe'
$env:EDITOR= 'nvim'

if (Get-Command oh-my-posh -errorAction SilentlyContinue) {
    oh-my-posh init pwsh --config "$($env:HOME)/.config/oh-my-posh/catppuccin.omp.toml" | Invoke-Expression
    . "$PSScriptRoot\completions\omp.ps1"
}

if (Get-Command zoxide -errorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
}

if (Get-Command chezmoi -errorAction SilentlyContinue) {
    . "$PSScriptRoot\completions\chezmoi.ps1"
}

if (Get-Command pip -errorAction SilentlyContinue) {
    if ((Test-Path Function:\TabExpansion) -and -not `
        (Test-Path Function:\_pip_completeBackup)) {
        Rename-Item Function:\TabExpansion _pip_completeBackup
    }
    function TabExpansion($line, $lastWord) {
        $lastBlock = [regex]::Split($line, '[|;]')[-1].TrimStart()
        if ($lastBlock.StartsWith("pip ")) {
            $Env:COMP_WORDS=$lastBlock
            $Env:COMP_CWORD=$lastBlock.Split().Length - 1
            $Env:PIP_AUTO_COMPLETE=1
            (& pip).Split()
            Remove-Item Env:COMP_WORDS
            Remove-Item Env:COMP_CWORD
            Remove-Item Env:PIP_AUTO_COMPLETE
        }
        elseif (Test-Path Function:\_pip_completeBackup) {
            # Fall back on existing tab expansion
            _pip_completeBackup $line $lastWord
        }
    }
}

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

