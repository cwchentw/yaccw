@echo off
rem wls.bat - Simulate Unix `ls` on Windows
rem Copyright (c) 2020 Michael Chen
rem Licensed under MIT


rem Limit the scopes of the variables in this script.
setlocal

rem Clean old state.
set pscmd=

rem Check whether PowerShell Core is available.
pswh -Help 1>nul 2>&1 && (
    set pscmd=pswh
)
rem Check whether PowerShell is available
rem  when PowerShell Core is not available.
if "%pscmd%" == "" (
    powershell -Help 1>nul 2>&1 && (
        set pscmd=powershell
    ) || (
        echo No PowerShell on the system >&2
        exit /B 1
    )
)

rem Clear old state
set show_hidden=

:parse_args
set dest=%1
if "%dest%" == "/?" goto help
if "%dest%" == "-h" goto help
if "%dest%" == "--help" goto help

if "%dest%" == "-a" (
    set show_hidden=1
    shift
    goto parse_args
)

if "%dest%" == "--all" (
    set show_hidden=1
    shift
    goto parse_args
)

if "%dest%" == "" (
    set dest=.
)

if "%show_hidden%" == "1" (
    set list_hidden=
) else (
    set list_hidden=-Exclude .*
)

%pscmd% -Command "Get-ChildItem %dest% %list_hidden% -Name | Sort-Object" || (
    echo Failed to show items in %dest% >&2
    exit /B 1
)

exit /B %ERRORLEVEL%

:help
echo Usage: %0 [option] [dest]
echo.
echo [dest] is a valid Windows path
echo When [dest] is empty, it implies current working directory
echo.
echo Option:
echo.    /?     Show help info and exit
echo     -h
echo     --help
echo.
echo     -a     List hidden files and directories
echo     --all
exit /B 0