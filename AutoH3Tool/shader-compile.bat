@echo off
:start_compile
if %c%==3 goto dump
set x="win"
set file=
echo Command: [%command%]
echo usage: %usage%
echo +-------------------------------------------------------+
echo         DRAG FILE OR FOLDER HERE AND PRESS ENTER
echo ---------------------------------------------------------
echo example: ...%example%
echo +-------------------------------------------------------+
set /p file=




if %c%==1 goto 1
goto exe
:1 
::echo !Shader file was not specified!?
if [%file%]==[] goto home

:exe
set file=%file:"=%
::this broke something!?
::if %file%==null goto nofile

mode con: cols=215 lines=50
COLOR 0B
cls

::removes unused portion of %file% C:\H3EK\tags\objects\weapons >becomes> objects\weapons

call set output=%%file:%cd%=%%

set output=%output:~6%

	if %c%==1 set output=%output:~0,-7%
	if %xBit%==1 set output=%output:~0,-7%
	

:tool
echo +-------------------------------------------------+
echo starting command:Tool %command% %TD%%output% %x%
echo +-------------------------------------------------+
echo tool %command% %TD%%output% %x%


tool %command% %TD%%output% %x%
echo +--------------------------------------------------+
pause
:home
call autoH3Tool.bat
:dump
set command=dump-render-method-options
set x=
goto tool