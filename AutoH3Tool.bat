@echo off
set tool=Tool_fast
if exist tool.exe goto intro
goto rats
:intro
title AutoH3Tool
set TD=
set scnr=0
set xBit=0
set file=null
set x=
cls
mode con: cols=75 lines=300
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
echo [1]    - Import level - Structure
echo [2]    - Build map file - Build-cache-file
echo [3][R] - Import model - Bulk - Render - Physics - Collision
echo [4]    - Import animations - Model-animations
echo [5][B] - Import Bitmaps - Bitmap_single
echo [6]    - Export models - Extract-import-info
echo [7]    - Export-bitmap
echo [M]    - Monitor-bitmaps-models-structures
echo [Q]    - Shader stuff
echo [T]    - Toggle Tool_fast - Curret_mode = %tool%
echo [C]    - Custom command
echo [I]    - Extra information
set /p Choice=Choice:
	if %Choice%==1 goto 1
	if %Choice%==2 goto 2
	if %Choice%==3 goto 3
	if %Choice%==R goto 3
	if %Choice%==r goto 3
	if %Choice%==4 goto 4
	if %Choice%==5 goto 5
	if %Choice%==b goto 5
	if %Choice%==B goto 5
	if %Choice%==6 goto 6
	if %Choice%==7 goto 7
	if %Choice%==Q goto Q
	if %Choice%==q goto Q
	if %Choice%==I goto	info
	if %Choice%==i goto info
	if %Choice%==M goto M
	if %Choice%==m goto M
	if %Choice%==t goto t
	if %Choice%==T goto t
	if %Choice%==C goto C
	if %Choice%==c goto C
	if %Choice% gtr 7  goto intro
	
:info
echo press enter to repeat last choice 
Pause >nul
goto intro
		:C
		echo Note: Do not add the Tool prefix
		set /p Choice=Command:
		set command=%choice%
		cd data
		goto tool
		goto intro
		:t
		if "%tool%"=="Tool_fast" (
    	set "tool=Tool"
    	goto intro
		)
		if "%tool%"=="Tool" (
    	set "tool=Tool_fast"
    	goto intro
		)
	
		:1
		set command=structure
		set example=\data\levels\multi\test\structure\test.ass
		set usage=create a .scenario and .scenario_structure_bsp from an .ass file
		cd data
		goto selection
		:2
		set command=build-cache-file
		set example=\tags\levels\multi\test\test.scenario
		set usage=create a .map file from a .scenario
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
		echo [5] - sky
		echo +------------------------------+
		set /p c=Choice:
		set example=data\objects\multi\test\render\render(.jms/.jmi)
		set usage=create a (.render)(.collision)(.physics)_model from a .jms or .jmi file
			
			if %c%==1 set command=bulk-import-model-folder
				if %c%==1 set example=data\objects\weapons\example
				if %c%==1 set usage=bulk import render, collision, and physics models from .jms or .jmi files (Must select folder containing render, physics, collision folders)
			if %c%==2 set command=Render
			if %c%==2 set x=final
			if %c%==3 set command=physics
			if %c%==4 set command=collision
			if %c%==5 set command=render-sky
			if %c% gtr 5 goto intro

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
			set usage=import .jma file to animation tag (Must select folder containing .jma file)
			cd data
			goto selection
		:5
		echo +------------------+
		echo [1] - Bitmap_single
		echo [2] - Bitmaps "bulk"
		echo +------------------+
		set /p c=Choice:
			set usage=import .tif/tiff files to .bitmaps either bulk for all in containing folder or for a single bitmap
			if %c%==1 set command=Bitmap_single
			if %c%==2 set command=Bitmaps
			if %c%==1 set example=data\levels\multi\chill\bitmaps\example(.tiff/.tif)
			if %c%==2 set example=data\levels\multi\chill\bitmaps
			cd data
			goto selection
		:6
		set command=extract-import-info
		set example=tags\objects\weapons\example\example(.render)(.collision)(.physics)(.scenario_structure_bsp)
		set usage=extract .jms or .ass file from selected tag
		cd tags
		set TD=tags\
		goto selection
		:7
		echo +------------------------------+
		echo [1] - Export-bitmap-DDS
		echo [2] - Export-bitmap-PFM
		echo [3] - Export-bitmap-TGA
		::echo [4] - export-bitmap-TIFF
		echo +------------------------------+
		set /p c=Choice:
			if %c%==1 set command=export-bitmap-dds
			if %c%==2 set command=export-bitmap-pfm
			if %c%==3 set command=export-bitmap-tga
			::if %c%==4 call bitmap-extractor.pyw
			
			if exist data\bitmap_exports goto 7-1
			goto MD
			:7-1
			set xBit=1
			cd tags
			set example=tags\objects\weapons\example\bitmaps\example.bitmap
			set usage=exports a "file.bitmap" to file(.DDS)(.PFM)(.TGA)
			goto selection

			if exist data\bitmap_exports goto 7-1
			goto MD
			:7-1
			set xBit=1
			cd tags
			set example=tags\objects\weapons\example\bitmaps\example.bitmap
			set usage=exports a "file.bitmap" to file(.DDS)(.PFM)(.TGA)
			goto selection
			:Q
	
			echo +------------------------------+
			echo [1] - compile-shader
			echo [2] - shaders
			echo [3] - dump-render-method-options
			echo +------------------------------+
			set /p c=Choice:
			if %c%==1 set command=compile-shader
			if %c%==2 set command=shaders
			if %c%==1 set usage=Compiles the template needed for a specific shader.
			if %c%==1 set example=example\shaders\example.shader
			if %c%==2 set usage=Compiles non-template shaders, only useful if you are writing custom shaders.
			if %c%==2 set example=example\shaders - or leave blank
			call AutoH3Tool\shader-compile.bat
			:M
	
			echo +------------------------------+
			echo [1] - Bitmaps
			echo [2] - Models
			echo [3] - Structure
			echo +------------------------------+
			set /p c=Choice:
			if %c%==1 set command=Monitor-bitmaps
			if %c%==2 set command=Monitor-models
			if %c%==3 set command=structures
			start cmd /k "color 0D & tool %command% & exit"
			goto intro

		
:selection
set file=
echo Command: [%command%]
echo usage: %usage%
echo +-------------------------------------------------------+
echo         DRAG FILE OR FOLDER HERE AND PRESS ENTER
echo ---------------------------------------------------------
echo example: ...%example%
echo +-------------------------------------------------------+
set /p file=
if [%file%]==[] goto nofile
set file=%file:"=%



:exe

::this broke something!?
::if %file%==null goto nofile

mode con: cols=215 lines=50
COLOR 0B
cls

::removes unused portion of %file% C:\H3EK\tags\objects\weapons >becomes> objects\weapons

call set output=%%file:%cd%=%%

set output=%output:~1%

	if %scnr%==1 set output=%output:~0,-9%
	if %xBit%==1 set output=%output:~0,-7%
	

:tool
echo +-------------------------------------------------+
echo starting command:%Tool% %command% %TD%%output% %x%
echo +-------------------------------------------------+
cd ../
	if %xBit%==1 set x=%cd%\data\bitmap_exports\
echo %tool% %command% %TD%%output% %x%


%tool% %command% %TD%%output% %x%
echo +--------------------------------------------------+
if %xBit%==1 goto Bitx
timeout /t 1 /nobreak >nul
pause
goto intro

:MD
md data\bitmap_exports
goto 7-1
:Bitx
echo Export location:%cd%\data\bitmap_exports
explorer "%cd%\data\bitmap_exports"
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
