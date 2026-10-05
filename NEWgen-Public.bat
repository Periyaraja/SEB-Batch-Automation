@echo off
setlocal
REM Coded by NightOwl
REM check administrator permission
color 0A
net session >nul 2>&1
if %errorlevel% neq 0 (
	echo Requesting Administrator Permission
	echo.
	powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath 'cmd.exe' -ArgumentList '/c','""%~f0""' -Verb RunAs"
	exit /b
	)
echo Running as administrator...
set "INSTALLER=%USERPROFILE%\Downloads\SEB_3.9.0.787_SetupBundle.exe"
REM Checking Whether the File exist or Not

if not exist "%INSTALLER%" (
	echo Installer Not found.
	pause
	exit /b
)

REM Jumping into Menu

goto MENU

REM Selection Menu
:MENU
cls
echo ================================
echo      SEB INSTALLATION MENU	    
echo      Version : Gen_1           
echo      Author  : NightOwl        
echo ================================
echo.
echo 1. Del_and_Reinstall Installation
echo 2. Find Patch
echo 3. Check SEB
echo 4. Exit
echo.
REM Choosing Section
choice /c 1234 /n /m "Choose an option [1-4] :"

REM Navigating the Option

if errorlevel 4 goto EXIT

if errorlevel 3 goto SEB_WITH_PATCH

if errorlevel 2 goto PATCH_RUN

if errorlevel 1 goto INSTALLATION_RUN


:Final_check
cls
echo =================================
echo		NEXT STEP
echo =================================
echo.
echo 1.Return to Menu
echo 2.EXIT
echo.

REM Getting Final option
choice /c 12 /n /m "Choose an option [1-2] :"

REM Navigating the option

if errorlevel 2 goto EXIT
if errorlevel 1 goto MENU

:PATCH_RUN
call :PATCH
goto Final_check

:INSTALLATION_RUN
call :INSTALLATION
goto Final_check

:SEB_WITH_PATCH
echo Starting Full Reinstall...
call :INSTALLATION
echo Patch functionality omitted from public version.
echo All tasks completed!
goto Final_check



REM ==============================================================================================
REM 					Reusable Code Section
REM ==============================================================================================

:PATCH
echo Patch functionality omitted from public version.
echo This experiment was performed in an isolated lab environment.
exit /b

:INSTALLATION
echo Deleting SEB start...
start "" /wait "%INSTALLER%" /uninstall /quiet /norestart
echo.
echo Uninstall completed.
echo Starting installation...
start "" /wait "%INSTALLER%" /install /quiet /norestart
if %errorlevel% equ 0 (
    echo Full reinstall completed successfully.
) else (
    echo Full reinstall may have failed. Error code: %errorlevel%
)
echo.
echo Installation Completed...(❁´◡`❁)

exit /b

:EXIT
echo.
echo Exiting without change..
exit /b



