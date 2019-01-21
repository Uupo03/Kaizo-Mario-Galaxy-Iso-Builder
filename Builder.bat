@ECHO off
:Builder
echo Ver. 1.0
echo /=============================================================\
echo I     Make sure you have WIT (Wiimms ISO Tool) installed!     I
echo I                   What do you want to do?                   I
echo I                       1. Build a .iso                       I
echo I                  2. Change Game ID of .iso                  I
echo I                  3. Change TMD ID of .iso                   I
echo I              4. Change internal name of .iso                I
echo I  (3. Will make a Wii create a new save file for the mod.)   I
echo \=============================================================/

SET /P Input=Please enter 1, 2, 3 or 4: 
IF %Input% EQU 1 GOTO :Build_Iso
IF %Input% EQU 2 GOTO :Change_GameID
IF %Input% EQU 3 GOTO :Change_TMD
IF %Input% EQU 4 GOTO :Change_Name
CLS
GOTO :Builder
exit


:Build_Iso
CLS
echo /===========================================\
echo I Let's Start by choosing the disc image... I
echo \===========================================/
SET /P  isoFile=Please enter the name of your disc image. (e.g. SMG.iso, SMG.wbfs): 
if not defined isoFile GOTO :Build_Iso
if not exist ".\%isoFile%" (
	echo /====================================\
	echo I        Disc image not found.       I
	echo I Press any key to enter a new name. I
	echo \====================================/
	pause >nul
	GOTO :Build_iso )

:Modded_File
CLS
echo /======================================================\
echo I What do you want the modded disc image to be called? I
echo \======================================================/
SET /P moddedFile=Please enter a name. (e.g. Kaizo Mario Galaxy.iso, Kaizo Mario Galaxy.wbfs): 
if not defined moddedFile GOTO :Modded_File
if exist ".\%moddedFile%" (
	echo /====================================\
	echo I        File Already exists!        I
	echo I Press any key to enter a new name. I
	echo \====================================/
	pause >nul
	GOTO :Modded_File )

CLS
echo /========================================\
echo I Disc image found, let's build the mod! I
echo I           Extracting files...          I
echo I         This will take a while.        I
echo \========================================/
if exist ".\Temp\" (
	rmdir /s /q ".\Temp\" >nul )
wit EXTRACT ".\%isoFile%" ".\Temp" >nul

CLS	
color 04
echo /============================================================\
echo I          WIT (Wiimms ISO Tool), is not installed.          I
echo I Please download and install it from https://wit.wiimm.de/. I
echo I                   Press any key to exit.                   I
echo \============================================================/
if not exist  ".\Temp" (
	pause >nul
	exit
)

CLS
color 07
echo /========================================\
echo I Disc image found, let's build the mod! I
echo I         Copying modded files...        I
echo I         This will take a while.        I
echo \========================================/

if exist ".\Temp\DATA\" (
	xcopy ".\mod files\All\*" ".\Temp\DATA\files" /E /Y >nul
	if exist ".\Temp\DATA\EuEnglish\" (
		xcopy ".\mod files\PAL\*" ".\Temp\DATA\files" /E /Y >nul
	) else (
		xcopy ".\mod files\NTSC\*" ".\Temp\DATA\files" /E /Y >nul
	)
) else (
	xcopy ".\mod files\All\*" ".\Temp\files" /E /Y >nul
	if exist ".\Temp\EuEnglish\" (
		xcopy ".\mod files\PAL\*" ".\Temp\files" /E /Y >nul
	) else (
		xcopy ".\mod files\NTSC\*" ".\Temp\files" /E /Y >nul
	)
)
CLS
echo /========================================\
echo I Disc image found, let's build the mod! I
echo I      Building modded disc image...     I
echo I         This will take a while.        I
echo \========================================/
wit COPY ".\Temp" ".\%moddedFile%" >nul
rmdir /s /q ".\Temp" >nul

CLS
echo /========================\
echo I         Done!          I
echo I Press any key to exit. I
echo \========================/
pause >nul
exit


:Change_GameID
CLS
echo /===========================================\
echo I Let's Start by choosing the disc image... I
echo \===========================================/
SET /P  isoFile=Please enter a name of your disc image file. (e.g. SMG.iso, SMG.wbfs): 
if not defined isoFile GOTO :Change_GameID
if not exist ".\%isoFile%" (
	echo /====================================\
	echo I        .iso file not found         I
	echo I Press any key to enter a new name. I
	echo \====================================/
	pause >nul
	GOTO :Change_GameID )

:New_GameID
CLS
echo /==================================\
echo I Now just choose the new Game ID. I
echo \==================================/
SET /P  newGameID=Please enter the new Game ID (e.g. RMGE02 or KAIZ01): 
if not defined newGameID GOTO :New_GameID
wit EDIT --id  %newGameID%  ".\%isoFile%" >nul
ren ".\txtcodes\RMGE01.txt" "%newGameID%.txt"

CLS
echo /========================\
echo I         Done!          I
echo I Press any key to exit. I
echo \========================/
pause >nul
exit



:Change_TMD
CLS
echo /===========================================\
echo I Let's Start by choosing the disc image... I
echo \===========================================/
SET /P  isoFile=Please enter a name of your disc image file. (e.g. SMG.iso, SMG.wbfs): 
if not defined isoFile GOTO :Change_TMD
if not exist ".\%isoFile%" (
	echo /====================================\
	echo I        .iso file not found         I
	echo I Press any key to enter a new name. I
	echo \====================================/
	pause >nul
	GOTO :Change_TMD )

:New_TMD
CLS
echo /==============================\
echo I Now just choose the new TMD. I
echo \==============================/
SET /P  newTMD=Please enter the new TMD (e.g. RMGE or KAIZ): 
if not defined newTMD GOTO :New_TMD
wit EDIT --tt-id  %newTMD%  ".\%isoFile%" >nul

CLS
echo /========================\
echo I         Done!          I
echo I Press any key to exit. I
echo \========================/
pause >nul
exit



:Change_Name
CLS
echo /===========================================\
echo I Let's Start by choosing the disc image... I
echo \===========================================/
SET /P  isoFile=Please enter a name of your disc image file. (e.g. SMG.iso, SMG.wbfs): 
if not defined isoFile GOTO :Change_Name
if not exist ".\%isoFile%" (
	echo /====================================\
	echo I        .iso file not found         I
	echo I Press any key to enter a new name. I
	echo \====================================/
	pause >nul
	GOTO :Change_Name )

:New_Name
CLS
echo /===============================\
echo I Now just choose the new name. I
echo \===============================/
SET /P  newName=Please enter the new name (Max 63 characters): 
if not defined newName GOTO :New_Name
wit EDIT --name  "%newName%"  ".\%isoFile%" >nul

CLS
echo /========================\
echo I         Done!          I
echo I Press any key to exit. I
echo \========================/
pause >nul
exit

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	