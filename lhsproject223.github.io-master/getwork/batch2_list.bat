@echo off
if %1. == . goto cmderror
set serversourcepath=%prompt%
set examplefile=%1
set depositfolder=%2
set period=%3
set masterperiod=%period%


rem initialize all to default values if currently not defined
if     %allpreps%.==. set allpreps=0
if  %logstudents%.==. set logstudents=0
if     %namepile%.==. set namepile=0
if %openfilename%.==. set openfilename=0
if      %openall%.==. set openall=0
if     %showcopy%.==. set showcopy=0
if    %openpause%.==. set openpause=0
if %masterperiod%.==. set masterperiod=0
if     %opencode%.==. set opencode=0
if     %openview%.==. set openview=0
if     %feedback%.==. set feedback=0
if %openeverything%.==. set openeverything=0



echo  seeking:%examplefile%     output:%depositfolder%      logx=%logstudents%
rem make directory for deposit folder
2>NUL md %depositfolder%
goto %period%


rem if period name fails to match
echo.
echo     Error, period requested not found
pause
goto end


:coding2period2
set period=coding2period2
call batch4prep.bat  %depositfolder% %period%  
echo Period 2 =========================


call batch3_work %examplefile% %depositfolder% %period%  	A T ATran7762    	An	Tran
call batch3_work %examplefile% %depositfolder% %period%  	j D JDonnelly0154	Joh	Donnelly






if %allpreps% == 1 goto       coding2period3
goto end




 

if %allpreps% == 1 goto       coding1period3
goto end



:coding2period3
set period=coding2period3
call batch4prep.bat  %depositfolder% %period%  
echo Period 3 =========================

 

if %allpreps% == 1 set period=%masterperiod%
goto end




:pchardwareperiod4
call batch4prep.bat  %depositfolder% %period%  
echo Period 4 =========================
 

if %allpreps% == 1 goto pchardwareperiod5
goto end	


 
if %allpreps% == 1 goto pchardwareperiod5
goto end							




:pchardwareperiod5
set period=pchardwareperiod5
call batch4prep.bat  %depositfolder% %period%  
echo Period 5 =========================


 


if %allpreps% == 1 set period=%masterperiod%
goto end

 

if %allpreps% == 1 set period=%masterperiod%
goto end



:mobileappsperiod6
set period=mobileappsperiod6


:coding1period6
set period=coding1period6
call batch4prep.bat  %depositfolder% %period%  
echo Period 6 =========================



 
 



:apps1period7
set period=apps1period7
call batch4prep.bat  %depositfolder% %period% 
echo Period 7 =========================
 



if %allpreps% == 1 set period=%masterperiod%
goto end



goto end
 



if %allpreps% == 1 set period=%masterperiod%
goto end




 

:apps1period8
set period=apps1period8
call batch4prep.bat  %depositfolder% %period% 
echo Period 8 =========================

 



if %allpreps% == 1 set period=%masterperiod%
goto end


 


:cmderror
notepad %~nx0
rem syntax above is the file name being excuted
goto end



 

goto end



rem check for variables that are not initialized, set to default values
if     %allpreps%.==. set allpreps=0
if  %logstudents%.==. set logstudents=0
if     %namepile%.==. set namepile=0
if  %logstudents%.==. set logstudents=0
if     %openedit%.==. set openedit=0
if %openfilename%.==. set openfilename=NUL
goto end




:end
echo.
echo. 

