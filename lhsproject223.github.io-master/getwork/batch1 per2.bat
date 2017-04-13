@echo off
set namepile=0
set logstudents=0
set allpreps=1
set editor="C:\Program Files (x86)\Sublime Text 2\sublime_text.exe"
set period=coding2period2
set depositfolder=java1a




:foldercheck
set examplefile=java\JavaCS1-2\
set sourcepath=java\JavaCS1-2\
set prompt=%sourcepath%
call batch2_list.bat %examplefile% %depositfolder% %period% 





:filecheck
set opencode=1
set openfilename=lab06.java
set examplefile=java\JavaCS1-2\lab06.java
set sourcepath=java\JavaCS1-2\lab06.java
set prompt=%sourcepath%
call batch2_list.bat %examplefile% %depositfolder% %period% 




goto end




  


 
 



 
rem	do not change below
rem     ===============================================================







rem check server drive 
if not exist s: goto drivebad
goto driveok
:drivebad 
echo.
echo trying to connect to sever....         
echo. 
net use s: \\besc-file.ad.ppsnet\Student > NUL
echo.
echo attempted to connect, try again
echo.
pause
goto end



:driveok
set prompt=$p$g
goto end




:end
echo.
echo Done ready to exit?
echo.
pause

