
if WinActive("ahk_exe Discord.exe") {
    ^+up::SendInput("!{Up}")
    ^+down::SendInput("!{Down}")
    ^+left::SendInput("!{Left}")
    ^+right::SendInput("!{Right}")
}
