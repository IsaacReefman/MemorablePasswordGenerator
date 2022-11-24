@ECHO OFF
SETLOCAL EnableDelayedExpansion
::'WHERE <command>' returns the location of the file that executes <command>. If it is not installed, _<command>Location will be undefined.
::'CLS' prevents unwanted text sitting in the console.
FOR /F %%G IN ('WHERE curl') DO SET _curlLocation=%%G
FOR /F %%G IN ('WHERE jq') DO SET _jqLocation=%%G
FOR /F %%G IN ('WHERE choco') DO SET _chocoLocation=%%G
CLS

::If either is undefined it will need to be installed for the program to run.
IF DEFINED _curlLocation GOTO jqCheck 
CHOICE /M "Curl is not installed. This program needs it to function. Install?"
IF !ERRORLEVEL! EQU 2 (
    SET /P _userAlert="Program cannot run, and will now close. " <NUL
    PAUSE
    EXIT
)
IF !ERRORLEVEL! EQU 1 (
    CALL :chocoCheck
    ECHO Installing Curl...
    CALL dependencyInstaller.bat curl
    EXIT /B
)

:jqCheck
IF DEFINED _jqLocation EXIT /B
CHOICE /M "jq is not installed. This program needs it to function. Install?"
IF !ERRORLEVEL! EQU 2 (
    SET /P _userAlert="Program cannot run, and will now close. " <NUL
    PAUSE
    EXIT
)
IF !ERRORLEVEL! EQU 1 (
    CALL :chocoCheck
    ECHO Installing jq...
    CALL dependencyInstaller.bat jq
    EXIT /B
)

:chocoCheck
::Install Chocolatey if it's not installed. (Asking first, of course)
IF NOT DEFINED _chocoLocation (
    CHOICE /M "Chocolatey (used to install dependencies) is not installed. Install?"
    IF !ERRORLEVEL! EQU 2 (
        SET /P _userAlert="Program cannot run, and will now close. " <NUL
        PAUSE
        EXIT
    )
    IF !ERRORLEVEL! EQU 1 (
        ECHO Installing Chocolatey...
        CALL dependencyInstaller.bat choco
        SET _chocoLocation=overRide
    )
)
EXIT /B