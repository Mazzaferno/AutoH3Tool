@echo off
title AutoH3Tool
if exist tool.exe goto intro
goto rats
:intro

set TD=
set scnr=0
set xBit=0
set file=null
set x=
cls

color 0D
echo "                            _  --  _                        
echo "     ___         __        / \|  |/ \  __________  ____  __ 
echo "    /   | __  __/ /_____   \  |  |  / /_  __/ __ \/ __ \/ / 
echo "   / /| |/ / / / __/ __ \ --  |  |  -- / / / / / / / / / /  
echo "  / ___ / /_/ / /_/ /_/ /\    '--'    / / / /_/ / /_/ / /___
echo " /_/  |_\__,_/\__/\____/  '--      --'_/  \____/\____/_____/
echo "                            /__/\__\                         
echo +-----------------------------------------------------------------------+
echo         AutoH3Tool is used to import and export H3 Tags for H3EK
echo             this tool automates H3EK's Tool.exe commands
echo +-----------------------------------------------------------------------+
echo   exported tags must be within \tags\.. imported data must be in \data\..
echo +-----------------------------------------------------------------------+
echo [1] - Structure
echo [2] - Build-cache-file
echo [3] - Import model - Bulk - Render - Physics - Collision
echo [4] - Model-animations
echo [5] - Bitmaps - Bitmap_single
echo [6] - Extract-import-info
echo [7] - Export-bitmap
echo +-----------------------------------------------------------------------+
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
		set scnr=1
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
			if %c%==2 set command=Render
			if %c%==3 set command=physics
			if %c%==4 set command=collision
			if %c% gtr 4 goto intro

			cd data
			goto selection
		:4
		echo +----------------------------------+
		echo [1] - model-animations
		echo [2] - model-animations-uncompressed
		echo +----------------------------------+
		set /p c=Choice:
			if %c%==1 set command=model-animations
			if %c%==2 set command=model-animations-uncompressed
			set example=data\objects\object\animations
			cd data
			goto selection
		:5
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
		:6
		set command=extract-import-info
		set example=tags\objects\weapons\example\example(.render)(.collision)(.physics)(.scenario_structure_bsp)
		cd tags
		set TD=tags\
		goto selection
		:7
		echo +------------------------------+
		echo [1] - Export-bitmap-DDS
		echo [2] - Export-bitmap-PFM
		echo [3] - Export-bitmap-TGA
		echo +------------------------------+
		set /p c=Choice:
			if %c%==1 set command=export-bitmap-dds
			if %c%==2 set command=export-bitmap-pfm
			if %c%==3 set command=export-bitmap-tga
			if exist data\bitmap_exports goto 7-1
			goto MD
			:7-1
			set xBit=1
			cd tags
			set example=tags\objects\weapons\example\bitmaps\example.bitmap
			goto selection
		
:selection
set file=null
echo Command: [%command%]
echo +-------------------------------------------------------+
echo         DRAG FILE OR FOLDER HERE AND PRESS ENTER
echo ---------------------------------------------------------
echo example: ...%example%
echo +-------------------------------------------------------+
set /p file=

:exe
if %file%==null goto nofile

COLOR 0B
cls

::removes unused portion of %file% C:\H3EK\tags\objects\weapons >becomes> objects\weapons

call set output=%%file:%cd%=%%

set output=%output:~1%

	if %scnr%==1 set output=%output:~0,-9%
	if %xBit%==1 set output=%output:~0,-7%
	
:tool
echo +-------------------------------------------------+
echo starting command:Tool %command% %TD%%output% %x%
echo +-------------------------------------------------+
cd ../
	if %xBit%==1 set x=%cd%\data\bitmap_exports\
	
tool %command% %TD%%output% %x%
echo +--------------------------------------------------+
if %xBit%==1 goto Bitx
pause
goto intro

:MD
md data\bitmap_exports
goto 7-1
:Bitx
echo Export location:%cd%\data\bitmap_exports
pause
goto intro

:nofile
COLOR 0C
cls
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

:rats
COLOR 0C
echo +------------------------------------------------------------------------------------+
echo  !!RATS!! Tool.exe was not detected.. make sure AutoH3Tool is in the H3EK directory.
echo +------------------------------------------------------------------------------------+
echo.
echo "                                   ...........                               
echo "                           `.-::/++ooooooossosoo+/::-.                     
echo "                        .-:////+o++++oooossssoysysyyyyhhyy+:`              
echo "                      `//:///+/+++++o+ooosssoosyyyyyyyshhhydho.            
echo "                     -:::::+/+//++oo++soHalo3ratosyyohsyhhhdhhdhs+:         
echo "    ```..``        ``-:::/+s/oo:/+++/+ooosssysshs/oshyoyhf_ghddhddy:      
echo "          ..`-......``..-////++++/+++ooosossyssyyyy:oyyssvddhhhydyydy`     
echo "                           .+//++o/oo/::-::::///:/+oh++ssyyyyyyso+/-       
echo "                            `-//oyo:                `:os`                 
echo "                                `-:+/.`                 ``                
echo "					 
echo +------------------------------------------------------------------------------------+
echo press anykey to exit
Pause >nul
exit
