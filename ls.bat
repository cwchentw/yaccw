@echo off
rem ls.bat - Simulate Unix `ls` on Windows
rem Copyright (c) 2020 Michael Chen
rem Licensed under MIT


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