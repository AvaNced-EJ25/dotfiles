
$env:PWSH_MOTD_HYFETCH=1

$MOTD_STAMP="$env:HOME/.motd_shown"

function hyfetch_cycle() {
    $ret=0
    $i=0
    $flags=@( "rainbow", "transgender", "lesbian", "transbian", "demigirl", "transfeminine", "sapphic", "progress", "interprogress" )
    $count=$flags.Count
    if (Test-Path $MOTD_STAMP) {
        $i=$(Get-Content $MOTD_STAMP)
    }

    if ($i -gt $count) {
        $i=0
    }

    $flag=$flags[$i]
    if (Test-Path env:PWSH_MOTD_HYFETCH ) {
        hyfetch -C "${HOME}/.config/hyfetch.json" -p "$flag"
        $ret=$LASTEXITCODE
    }

    if ($ret -eq 0) {
        $i=$((($i+1) % $count))
        Set-Content $MOTD_STAMP -Value "$i"
    }
}

# PWSH MOTD - once every 3 hours
if ( (Test-Path env:PWSH_MOTD_ALWAYS) -or ((Get-Item $MOTD_STAMP -ErrorAction SilentlyContinue).LastWriteTime -lt (Get-Date).AddHours(-3)) ) {
    hyfetch_cycle
}

