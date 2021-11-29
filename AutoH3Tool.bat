@echo off
COLOR 0D
title AutoH3Tool
set filefolder=0
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework" 2>nul
cls
if errorlevel 1 (
    echo +-------------------------------------+
    echo  ERROR .NET Framework in not detected
    echo +-------------------------------------+
    goto choice
) else (
    goto intro
)

:choice
set /P c=open .netframework download page[y/n]?
if /i %c%==y goto download
if /i %c%==n goto end

:download
start "" https://dotnet.microsoft.com/download/dotnet-framework
pause
goto end

:intro
echo +-----------------------------------------------------------------------+
echo         AutoH3Tool is used to import and export H3 Tags for H3EK
echo             this tool automates H3EK's Tool.exe commands
echo +------------------------------------------------------------------------------------------------+
echo developed by Mazzaferno
echo +-----------------------------------------------+
echo !make sure you have .NET framework installed!
echo +-----------------------------------------------+
set file=null
if exist tags\ (
	
  goto command 
) else (
  powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('autotool must be in (steamapps\common\H3EK) directory', 'Error', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}"
goto end
)
pause



:: command choice

:Command
echo [1] export
echo [2] import
set /P c=Type:
cls
	if %c%==1 goto export
	if %c%==2 goto import
	goto intro
:export
	echo             select one of the following file types to export
	echo +--------------------------------------------------------------------------+
	echo    .render_model, .collision_model, .physics_model, .scenario_structure_bsp
	echo +--------------------------------------------------------------------------+
	echo files must be within "...H3EK\tags" directory 
	echo +--------------------------------------------------------------------------+
	set command=extract-import-info
	set TD=tags\
	goto start
:import
	echo                       [import type]
	echo +-----------------------------------------------------------------------------------------------------+
	echo [1] Structure  ".ass to BSP"
	echo     usage: "..H3EK\data\level\multi\test\structure\test.ass"
	echo +-----------------------------------------------------------------------------------------------------+
	echo [2] Bulk-import-model-folder
	echo  "compiles the render, collision, and physics directory of a model"
	echo    usage: "..H3EK\data\mystuff\mymodel"
	echo   "\mymodel" should contain folders named \collision\ \render\ \physics\ containing appropriate.JMS files!!
	echo +-----------------------------------------------------------------------------------------------------+
	set c=0
	set /P c=Type:
		if %c%==1 goto structure
		if %c%==2 goto bulk-import-model-folder
	set c=0
	cls
	if %c%==0 goto import
	goto import
	echo %command%
	pause
:structure
	set command=structure
	set TD=
	set filefolder=1
	goto start
:bulk-import-model-folder
	cls
	set command=bulk-import-model-folder
	set TD=
	set filefolder=1
	goto start

:: command choice end



:start
if %filefolder%==1 goto folder
cd tags
call :filedialog file
exit /b
:filedialog :: &file
setlocal
set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
set dialog=%dialog%close();resizeTo(0,0);</script>"
for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "file=%%p"
endlocal  & set %1=%file%
goto exe
:: execute command

:folder
echo +-------------------------------------------------------+
echo drag file or folder here and press enter
echo usage: ...H3EK\data\mystuff\mymodel
echo +-------------------------------------------------------+
set /p file=
cd data
:exe
cls
if %file%==null goto nofile
set folder=%cd%
call set output=%%file:%cd%=%%
set output=%output:~1%
cd ../
COLOR 0B
echo %command% %TD%%output%
tool %command% %TD%%output%
pause
exit

:nofile
COLOR 0C
echo +--------------------+
echo  No file was selected
echo +--------------------+
echo %command% %TD%%output%
pause

:end
exit
