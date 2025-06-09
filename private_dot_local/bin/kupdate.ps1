#!/bin/env -S echo "This is a powershell script lol, try again"

param(
    [switch]$admin
)

# Admin stuff here
if ( $admin.IsPresent ) {
    if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
        Write-Host "Updating chocolatey packages..."
        choco upgrade all -y
        Write-Host "Done."
    }

    if (Get-Command winget.exe -ErrorAction SilentlyContinue) {
        Write-Host "Updating winget packages..."
        winget upgrade --all
        Write-Host "Done."
    }

    return
}

Get-Command -Name "komorebic" -ErrorAction SilentlyContinue -ErrorVariable komorebic_installed | Out-Null
$komorebic_installed = ($komorebic_installed.Capacity -eq 0)
if ( $komorebic_installed ) {
    komorebic stop --bar --ahk
}

if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Write-Host "Updating Scoop packages..."
    scoop update --all
    Write-Host "Done."
}

if ( $komorebic_installed ) {
    komorebic fetch-asc
    komorebic start --bar --ahk
}

if (Get-Command chezmoi.exe -ErrorAction SilentlyContinue) {
    Write-Host "Updating Chezmoi..."
    chezmoi update
    Write-Host "Done."
}

if (Get-Command spicetify.exe -ErrorAction SilentlyContinue) {
    Write-Host "Updating spotify..."

    Stop-Process -Name Spotify
        winget upgrade spotify
        Write-Host "Done."
        winget upgrade spotify
        Write-Host "Done."

        Write-Host "Updating spicetify..."
        spicetify update
        Write-Host "Done."
}

if (Get-Command rustup -ErrorAction SilentlyContinue) {
    rustup up
}

# Run your code that needs to be elevated here
if (Get-Command sudo.exe -ErrorAction SilentlyContinue) {
    sudo -E powershell -NoLogo -File $PSCommandPath -admin
} else {
    Write-Warning "Please enable the sudo program and rerun this script"
}

return
