@echo off
set namepile=0
set logstudents=0
set allpreps=1
set editor="C:\Program Files (x86)\Sublime Text 2\sublime_text.exe"


set period=coding2period2
set depositfolder=code2_chap04_april11

goto ex


set examplefile=ddccode2\chap04
set sourcepath=ddccode2\chap04\
set prompt=%sourcepath%
call batch2_list.bat %examplefile% %depositfolder% %period% 


set examplefile=chap04\anyfile.css
set  sourcepath=ddccode2\chap04\*.css
set prompt=%sourcepath%
call batch2_list.bat %examplefile% %depositfolder% %period% 


:ex
set opencode=1
set feedback=0
set openfilename=april11.html
set examplefile=chap04\april11.html
set  sourcepath=ddccode2\chap04\april11.html
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

