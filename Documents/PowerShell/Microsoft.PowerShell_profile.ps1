Set-PSReadLineOption -PredictionSource HistoryAndPlugin -HistoryNoDuplicates -ShowToolTips -Colors @{ InlinePrediction = "`e[38;2;245;189;230m" }

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Cursor

Set-PSReadLineKeyHandler -Chord "Ctrl+\" -Function AcceptSuggestion

if (Get-Command rustup -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (rustup completions powershell | Out-String)})
}

if (Get-Command bat -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (bat --completion ps1 | Out-String)})
}

# pip powershell completion start
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
# pip powershell completion end


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

function reboot-func {
    if ( -not $args ) {
        $shutdown_args = 0
    } else {
        $shutdown_args = $args
    }

    shutdown /r /t $shutdown_args
}

# Add ~/.local/bin to PATH if it exists
$local_bin="$env:HOME\.local\bin"
if ( (Test-Path $local_bin) -and (-not ($env:PATH -like "*$local_bin*") ) ) {
    $env:PATH += ";$local_bin;"
}

$env:FZF_DEFAULT_OPTS="--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 --height 40% --layout=reverse --border --info=inline"
$env:LG_CONFIG_FILE="$env:HOME\.config\lazygit\config.yml,$env:HOME\.config\lazygit\pink.yml"
$env:EZA_CONFIG_DIR="$env:HOME\.config\eza"

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

#New-Alias -Name more less.exe
$env:PAGER = 'less.exe'
$env:EDITOR= 'nvim'

if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    oh-my-posh init pwsh --config "$($env:HOME)/.config/oh-my-posh/catppuccin.omp.toml" | Invoke-Expression
}

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
}

if (Get-Command chezmoi -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (chezmoi completion powershell | Out-String)})
}

if (Test-Path -Path "$PSScriptRoot\functions") {
    Get-ChildItem "$PSScriptRoot\functions" -Filter *.ps1 | Foreach-Object {
        . "$($_.FullName)"
    }
}

