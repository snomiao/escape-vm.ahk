#Persisted
global FLAG_CtrlShiftAlt按下 := 0

return

CtrlShiftAlt按下() {
    FLAG_CtrlShiftAlt按下 := 1
}

~$<!<+LCtrl:: CtrlShiftAlt按下()
~$<^<+LAlt:: CtrlShiftAlt按下()
~$<!<^LShift:: CtrlShiftAlt按下()

~$<!<+LCtrl Up:: CtrlShiftAltUp()
~$<^<+LAlt Up:: CtrlShiftAltUp()
~$<!<^LShift Up:: CtrlShiftAltUp()

CtrlShiftAltUp() {
    if (!(A_PriorKey == "LCtrl" || A_PriorKey == "LAlt" || A_PriorKey == "LShift")) {
        Return
    } ; debounce
    if (上次CtrlShiftAlt锁) {
        return
    }
    if (!FLAG_CtrlShiftAlt按下) {
        return
    }
    FLAG_CtrlShiftAlt按下 := 0

    上次CtrlShiftAlt锁 := 1
    ToolTip, % "双击 LCtrl LAlt LShift 来最后置当前窗口（主要用于虚拟机和远程桌面）"
    SetTimer, 窗口增强_RemoveToolTip, -1024
    现在 := A_TickCount
    间隔 := 现在 - 上次CtrlShiftAlt时刻
    if (间隔 < 200) {
        CurrentWindowSetAsBackground()
    } else {
        上次CtrlShiftAlt时刻 := 现在
    }
    上次CtrlShiftAlt锁 := 0
    return
}
CurrentWindowSetAsBackground()
{
    ; 后置当前窗口
    WinGet hWnd, id, A
    上次mstsc窗口hWnd := hWnd
    WinSet Bottom, , ahk_id %hWnd%
    ; 激活任务栏，夺走焦点
    WinActivate ahk_class Shell_TrayWnd
}
