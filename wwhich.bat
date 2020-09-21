@echo off
rem wwhich.bat - Simulate Unix which on Windows
rem Copyright (c) 2020 Michael Chen
rem Licensed under MIT.

rem It depends on wwhich.ps1 at the same system path.


rem Limit the scopes of the variables in the script.
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
        goto :fallback
    )
)

set root_dir=%~dp0

if not exist %root_dir%\wwhich.ps1 (
  echo No valid wwhich.ps1 >&2
  exit /B 0
)

%pscmd% -File %root_dir%\wwhich.ps1 %*

exit /B %ERRORLEVEL%

rem Use `where` as the fallback command.
:fallback
where %*
