#f::Send("#e")

#HotIf WinActive("ahk_exe Discord.exe")
^+up::SendInput("!{Up}")
^+down::SendInput("!{Down}")
^+left::SendInput("!{Left}")
^+right::SendInput("!{Right}")

#Hotif
