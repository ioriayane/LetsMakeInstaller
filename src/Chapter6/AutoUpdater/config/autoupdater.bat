@echo off

set APP_PATH="c:\Program Files (x86)\HelloWorld\maintenancetool.exe"
set SCRIPT_PATH=%~dp0controlscript.qs

REM �X�V�m�F
%APP_PATH% --checkupdates

if %errorlevel% == 0 (
echo �X�V����
%APP_PATH% --updater --script %SCRIPT_PATH%
) else (
echo �X�V�Ȃ�
)

