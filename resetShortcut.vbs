Set objShell = WScript.CreateObject ("WScript.Shell")
rootPath = (objShell.CurrentDirectory)
shPath = (rootPath & "\Memorable Password Generator.lnk")
btPath = ("""" & rootPath & "\res\NewMemorablePassword.bat""")
tgPath = ("C:\Windows\System32\cmd.exe")
shArg1 = (" /c ")
icPath = (rootPath & "\res\MLock.ico")

Set sh = CreateObject("WScript.Shell")
Set shortcut = sh.CreateShortcut(shPath)
shortcut.TargetPath = tgPath
shortcut.Arguments = (shArg1 & btPath)
shortcut.IconLocation = icPath
shortcut.Save
shortcut.WorkingDirectory = rootPath

WScript.Echo ("Shortcut Updated.")