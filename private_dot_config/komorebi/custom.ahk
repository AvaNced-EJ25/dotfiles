SetTitleMatchMode("RegEx")

; Map Win+F and Alt+F to Win+E for file explorer
#f::Send("#e")
!f::Send("#e")

#HotIf WinActive("ahk_exe Discord.exe")
^+up::SendInput("!{Up}")
^+down::SendInput("!{Down}")
^+left::SendInput("!{Left}")
^+right::SendInput("!{Right}")

; Remap Alt+Shift+<Direction> to Alt+<Direction> for file browsing
#HotIf WinActive("ahk_exe i)(files|explorer)\.exe$")
!+up::SendInput("!{Up}")
!+down::SendInput("!{Down}")
!+right::SendInput("!{Right}")
!+left::SendInput("!{Left}")

#Hotif
