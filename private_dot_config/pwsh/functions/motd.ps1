
$env:PWSH_MOTD_HYFETCH=1

$motd_stamp="$env:HOME/.motd_shown"

function print_header() {
    New-Item "$motd_stamp" -ErrorAction SilentlyContinue | Out-Null
    $flag=$(Get-Content $motd_stamp)

    if (-not $flag) {
        $flag="transgender"
    }

    # Custom message
    if (Test-Path env:PWSH_MOTD_HYFETCH ) {
        hyfetch -C "${HOME}/.config/hyfetch.json" -p "$flag"
    }

    if ("$flag" -eq "transgender" ) {
        $flag="lesbian" 
    } else {
        $flag="transgender"
    }

    Set-Content $motd_stamp -Value "$flag"
}

# PWSH MOTD - once every 3 hours
if ( (Test-Path env:PWSH_MOTD_ALWAYS) -or ((Get-Item $motd_stamp -ErrorAction SilentlyContinue).LastWriteTime -lt (Get-Date).AddHours(-3)) ) {
    print_header
}

