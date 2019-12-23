@echo off
setlocal
set "hour_to_run=%time:~0,2%"
set "min_to_run=%time:~3,2%"
if %hour_to_run% lss 10 set "hour_to_run=%hour_to_run:~-1%"
if %min_to_run% lss 10 set "min_to_run=%min_to_run:~-1%"
set /a "min_to_run+=1"
if %min_to_run%==60 (
set "min_to_run=0"
set /a "hpur_to_run+=1"
if %hour_to_run%==24 set "hour_to_run=0"
)
if %hour_to_run% lss 10 set "hour_to_run=0%hour_to_run%"
if %min_to_run% lss 10 set "min_to_run=0%min_to_run%"
set "time_to_run=%hour_to_run%:%min_to_run%"
echo %time_to_run%
at %time_to_run% /interactive "C:\2.bat"