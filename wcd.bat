@echo off
rem wcd.bat - Simulate Unix `cd` on Windows
rem Copyright (c) 2020 Michael Chen
rem Licensed under MIT


set drive=%~d0
set dest=%~1

rem Show help info and exit.
if "%dest%" == "/?" goto help
if "%dest%" == "-h" goto help
if "%dest%" == "--help" goto help

rem Set special destination.
if "%dest%" == "" set dest=%USERPROFILE%
if "%dest%" == "\" set dest=%drive%\
if "%dest%" == "/" set dest=%drive%\

rem Replace ~ with home directory.
if "%dest:~0,1%" == "~" (
   set dest=%USERPROFILE%\%dest:~2%
)

if "%dest%" == "-" (
   set dest=%last_working_directory%
)

if "%dest%" == "" (
  echo No previous working directory recorded >&2
  exit /B 1
)

rem Keep last working directory in session variable
set last_working_directory=%CD%

cd "%dest%" || (
  echo Failed to visit %dest% >&2
  exit /B 1
)

exit /B 0

:help
echo Usage: %0 [dest]
echo.
echo Change directory to [dest]
echo [dest] is any valid Windows path.
echo.
echo Special [dest]:
echo.
echo     An empty [dest] means user home directory
echo.
echo     ~ means user home directory
echo.
echo     / or \ means the root path of current drive

exit /B 0
