@echo off
rem wcat.bat - simulate Unix `cat` on Windows
rem Copyright (c) 2020 Michael Chen.
rem Licensed under MIT


:parse_args
set arg=%1
shift
if "%arg%" == "" goto end
if exist "%arg%" type %arg%
goto parse_args

:end
exit /B %ERRORLEVEL%
