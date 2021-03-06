:: Name:     copy_from_myPolygons.cmd
:: Purpose:  Copy geojsons from myPolygons directory
:: Author:   pierre@pvln.nl
:: Revision: 2020 06 07 - initial version
::
:: Required environment variables
:: ==============================
:: - VERBOSE         			  how verbose output should be if not set script sets it to YES
::
@ECHO off
SETLOCAL ENABLEEXTENSIONS

:: BASIC SETTINGS
:: ==============
:: Setting the name of the script
SET me=%~n0
:: Setting the name of the directory with this script
SET parent=%~p0
:: Setting the drive of this commandfile
SET drive=%~d0
:: Setting the directory and drive of this commandfile
SET cmd_dir=%~dp0

::
:: Check if required environment variables are set.
:: If not set them to a safe default value or exit with error.
:: 
IF "%VERBOSE%" == "" (
   SET VERBOSE=YES
)

SET geojsonsFromPath=..\..\..\..\myPolygons
SET geojsonsToPath=.\src\media\geojsons

::
:: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/xcopy
::
:: /d [:MM-DD-YYYY]  Copies source files changed on or after the specified date only.
::                   If you do not include a MM-DD-YYYY value, xcopy copies all Source files that are newer than existing Destination files.
::                   This command-line option allows you to update files that have changed.
:: /i                If Source is a directory or contains wildcards and Destination does not exist, xcopy assumes Destination specifies a directory name and creates a new directory.
::                   Then, xcopy copies all specified files into the new directory. By default, xcopy prompts you to specify whether Destination is a file or a directory.
:: /s                Copies directories and subdirectories, unless they are empty. If you omit /s, xcopy works within a single directory.
:: /e                Copies all subdirectories, even if they are empty. Use /e with the /s and /t command-line options.
:: /y                Suppresses prompting to confirm that you want to overwrite an existing destination file.

IF %VERBOSE%==YES ECHO ... Copying chambers
xcopy %geojsonsFromPath%\chambers\* %geojsonsToPath%\chambers /s /e /i /y /d

IF %VERBOSE%==YES ECHO ... Copying contours
xcopy %geojsonsFromPath%\contours\* %geojsonsToPath%\contours /s /e /i /y /d

IF %VERBOSE%==YES ECHO ... Copying locks
xcopy %geojsonsFromPath%\locks\* %geojsonsToPath%\locks /s /e /i /y /d 

IF %VERBOSE%==YES ECHO ... Copying ports
xcopy %geojsonsFromPath%\ports\* %geojsonsToPath%\ports /s /e /i /y /d

IF %VERBOSE%==YES ECHO ... Copying quays
xcopy %geojsonsFromPath%\quays\* %geojsonsToPath%\quays\ /s /e /i /y /d 

IF %VERBOSE%==YES ECHO ... Copying sets
xcopy %geojsonsFromPath%\sets\* %geojsonsToPath%\sets\ /s /e /i /y /d

IF %VERBOSE%==YES ECHO ... Done copying

GOTO CLEAN_EXIT

:ERROR_EXIT
cd "%cmd_dir%" 
ECHO *******************
ECHO %ERROR_MESSAGE%
ECHO *******************
   
:CLEAN_EXIT   
:: Wait some time and exit the script
::
timeout /T 10