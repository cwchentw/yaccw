@echo off
rem wdl.bat - Download data within the command line
rem Copyright (c) 2020 Michael Chen
rem Licensed under MIT


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
        echo No PowerShell on the system >&2
        exit /B 1
    )
)

set target=%1

rem Show help info and exit.
if "%target%" == "/?" goto help
if "%target%" == "-h" goto help
if "%target%" == "--help" goto help

if "x%target%" == "x" (
  echo No valid target >&2
  exit /B 1
)

set url=%2

if "x%url%" == "x" (
  rem %target% is a URL.
  goto parse_target
) else (
  rem %target% is a file path.
  goto download_target
)

:parse_target
rem Check whether the command is available in PowerShell
%pscmd% -Command "Get-Command -Name [System.IO.Path]::GetFileName -ErrorAction SilentlyContinue" 2>nul 1>&2
if not "%ERRORLEVEL%" == "0" (
  echo [System.IO.Path]::GetFileName is not supported on the system >&2
  exit /B 1
)

set url=%target%
set cmd=%pscmd% -Command "[System.IO.Path]::GetFileName(\"%target%\")"

for /F %%f in ('%cmd%') do (
  set target=%%f
)

:download_target
if "x%target%" == "x" (
  echo No valid target >&2
  exit /B 1
)

rem Check whether the command is available in PowerShell
%pscmd% -Command "Get-Command -Name Invoke-WebRequest -ErrorAction SilentlyContinue" 1>nul 2>&1

if not "%ERRORLEVEL%" == "0" (
  echo Invoke-WebRequest cmdlet is not supported on the system >&2
  exit /B 1
)

%pscmd% -Command "Invoke-WebRequest -Uri %url% -OutFile %target%"

exit /B %ERRORLEVEL%

:help
echo Usage %0 [dest] [url]
echo.
echo Download data from [url] to [dest]
echo.
echo [dest] is optional.  When [dest] is empty, %0 will
echo  parse a valid [dest] from [url]

exit /B 0
