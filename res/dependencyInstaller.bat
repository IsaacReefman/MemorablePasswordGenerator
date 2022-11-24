@ECHO OFF
SETLOCAL
::Check if running as admin, and prompt user to re-start elevated if not.
CALL :isAdmin
IF %errorlevel% == 0 (
    GOTO installDependency
) ELSE (
    ECHO Install access denied. Please run NewMemorablePassword as administrator in
    SET /P _userAlert="order to install dependencies. (Future uses will not need this.)" <NUL
    ECHO.
    PAUSE
    EXIT
)

:isAdmin
::fsutil dirty query is only allowed with admin privileges
fsutil dirty query %systemdrive% >nul
EXIT /b

:installDependency
::Install the missing software
IF [%1]==[choco] (
    start /w cmd /C @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
) ELSE (
    start /w cmd /C choco install %1 -y -r
)
ENDLOCAL