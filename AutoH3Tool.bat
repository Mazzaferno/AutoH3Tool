@echo off
:intro
set TD=
set scnr=0
set file=null
cls
mode con: cols=75 lines=50
color 0D
echo "                           _  --  _                        
echo "    ___         __        / \|  |/ \  __________  ____  __ 
echo "   /   | __  __/ /_____   \  |  |  / /_  __/ __ \/ __ \/ / 
echo "  / /| |/ / / / __/ __ \ --  |  |  -- / / / / / / / / / /  
echo " / ___ / /_/ / /_/ /_/ /\    '--'    / / / /_/ / /_/ / /___
echo "/_/  |_\__,_/\__/\____/  '--      --'_/  \____/\____/_____/
echo "                           /__/\__\                         
echo +-----------------------------------------------------------------------+
echo         AutoH3Tool is used to import and export H3 Tags for H3EK
echo             this tool automates H3EK's Tool.exe commands
echo +-----------------------------------------------------------------------+
echo.
echo +--------------select command------------+
echo [1] - structure
echo [2] - build-cache-file
echo [3] - import model - Bulk - Render - Physics - Collision
echo [4] - model-animations
echo [5] - model-animations-uncompressed
echo [6] - extract-import-info
echo [7] - Bitmaps - bitmap_single
echo +----------------------------------------+
set /p c=Choice:
	if %c%==1 goto 1
	if %c%==2 goto 2
	if %c%==3 goto 3
	if %c%==4 goto 4
	if %c%==5 goto 5
	if %c%==6 goto 6
	if %c%==7 goto 7
	if %c% gtr 7  goto intro
	
		:1
		set command=structure
		set example=\data\levels\multi\test\structure\test.ass
		cd data
		goto selection
		:2
		set command=build-cache-file
		set example=\tags\levels\multi\test\test.scenario
		cd tags
		set TD=tags\
		goto selection		
		:3
		echo +------------------------------+
		echo [1] - bulk-import-model-folder
		echo [2] - Render
		echo [3] - physics
		echo [4] - collision
		echo +------------------------------+
		set /p c=Choice:
		set example=data\objects\multi\test\render\render(.jms/.jmi)
			
			if %c%==1 set command=bulk-import-model-folder
				if %c%==1 set example=data\objects\multi\test
				if %c%==1 set scnr=1
			if %c%==2 set command=Render
			if %c%==3 set command=physics
			if %c%==4 set command=collision
			if %c% gtr 4 goto intro

		cd data
		goto selection
		:4
		set command=model-animations
		set example=
		goto selection
		:5
		set command=model-animations-uncompressed
		set example=
		goto selection
		:6
		set command=extract-import-info
		set example=tags\objects\weapons\example\example(.render)(.collision)(.physics)(.scenario_structure_bsp)
		cd tags
		set TD=tags\
		goto selection
		:7
		echo +------------------+
		echo [1] - Bitmap_single
		echo [2] - Bitmaps "bulk"
		echo +------------------+
		set /p c=Choice:
			if %c%==1 set command=Bitmap_single
			if %c%==2 set command=Bitmaps
			if %c%==1 set example=data\levels\multi\chill\bitmaps\example(.tiff/.tif)
			if %c%==2 set example=data\levels\multi\chill\bitmaps
			cd data
		goto selection

:selection
set file=null
echo Command: [%command%]
echo +-------------------------------------------------------+
echo         DRAG FILE OR FOLDER HERE AND PRESS ENTER
echo ---------------------------------------------------------
echo usage: ...%example%
echo +-------------------------------------------------------+
set /p file=

:exe
COLOR 0B
cls
if %file%==null goto nofile

::removes unused portion of %file% C:\H3EK\tags\objects\weapons >becomes> objects\weapons

call set output=%%file:%cd%=%%

set output=%output:~1%

	if %scnr%==1 set output=%output:~0,-9%

:tool

echo starting command:Tool %command% %TD%%output%
cd ../
echo tool %command% %TD%%output%
pause
goto intro


:nofile
COLOR 0C
echo +--------------------+
echo  No file was selected
echo +--------------------+
echo %command% %TD%%output%
echo "     _  --  _
echo "    / \|  |/ \
echo "    \  |  |  /
echo "   --  |  |  -- 
echo "  \    '--'    /
echo "   '--      --'
echo "     /__/\__\
echo "
cd ../
pause
cls
goto intro

:end
exit
