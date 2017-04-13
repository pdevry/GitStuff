@echo off
rem Skip to end if paramaters are missing 
if %1. == . goto cmderror

set mydelay=0
set examplefile=%1
set depositfolder=%2
set period=%3
set shortperiod=%period:~-1%
rem shortperiod is last char on period string,  example=2
set fi=%4
set li=%5
set id=%6
set firstname=%7
set lastname=%8

set fullname=%firstname%_%lastname%
set templog=%random%.txt
set temperror=%prompt:~-35%
set serversourcepath="s:\%fi%\%li%\%id%\%prompt%%"
set  missingid=%id:~-3%_missing_work_report.txt
set startingid=%id:~-3%_starting_work_report.txt
set folderid=%fullname:~0,5%%id:~-3%
set shortFolderId=%id:~-3%teacher_notes



set serverlogspath="x:\CTE_STUDENTS\mr_rowe\notes_feedback\

set studentgoodreport=%serverlogspath%%period%\%startingid%"
set  studentbadreport=%serverlogspath%%period%\%missingid%"
set   stuFeedbackFolder=%serverlogspath%%period%\%folderid%"


  


rem we use prompt variable because it can contain spaces and retains spaces


if  %prompt:~-1% == \  goto xcopydirectory
goto copyjustfiles


:xcopydirectory
rem if path ends in \ that means we want a directory copy only
set foldername=%prompt:~0,-1%
rem removed extra slash from end
set serversourcepath="s:\%fi%\%li%\%id%\%foldername%%"


rem run dir command to check if files exists
2>NUL dir %serversourcepath%                          >NUL
if errorlevel 1 goto nodir


rem make destination folder and use xcopy
2>NUL md                   %depositfolder%\%shortperiod%_%firstname%_%li%  >NUL
xcopy %serversourcepath%   %depositfolder%\%shortperiod%_%firstname%_%li%  /E /Y /S > %templog%   
rem  /L is display for xcopy 
rem  copy %serversourcepath%   %depositfolder%\%shortperiod%_%firstname%_%li%       /Y    > %templog%   
rem xcopy %serversourcepath%   %depositfolder%\%shortperiod%_%firstname%_%li% /L /E /Y /S > %templog%   


rem question... did xcopy report "0 files" in temp log?  Empty folder check here
find /V "0 File(s) copied" %templog%  >NUL 
if errorlevel 1 goto emptydir


del %templog%
echo %firstname% %li% ok
echo %firstname% %lastname% foundFolder       >> logs\log_ok_%period%.txt
if %logstudents% == 1 echo found folder named: %examplefile% in %prompt%      %date% %time% >> %studentgoodreport%  


if %opencode%==1  goto opencode
if %openview%==1  goto openview
if %openall%==1 goto openeverything
goto end



:copyjustfiles

rem use copy not xcopy and check if source exists using dir command
2>NUL dir %serversourcepath%                          >NUL
if errorlevel 1 goto nofile

echo %firstname% %li% ok
echo %firstname% %lastname% ok        >> logs\log_ok_%period%.txt
if %logstudents% == 1 echo good work starting: %examplefile% in %prompt%      %date% %time% >> %studentgoodreport%
2>NUL md                          %depositfolder%\%shortperiod%_%firstname%_%li%  >NUL
2>NUL copy %serversourcepath%     %depositfolder%\%shortperiod%_%firstname%_%li%  >NUL 

if %showcopy%==1 copy %serversourcepath%     %depositfolder%\%shortperiod%_%firstname%_%li% 
if %showcopy%==1 copy %serversourcepath%     %depositfolder%\%shortperiod%_%firstname%_%li% >> %studentgoodreport%  

rem done with copy file


:feedback
if %feedback%==0 goto opencode
REM make directory on server, teacher can edit, students can read
2>NUL md                        %stuFeedbackFolder%  
2>NUL copy %serversourcepath%   %stuFeedbackFolder%  >NUL
echo rename   %stuFeedbackFolder% %shortFolderId%    >>    %serverlogspath%%period%\clickme.bat

:feedback2
rem launch editor on feedback file the teacher can edit
if %opencode%==0 goto openview
set myparameter=%stuFeedbackFolder%\%openfilename%
start "" %editor% %myparameter% 
goto openview


:opencode
if %opencode%==0 goto openview
rem launch file name using extension association 
set myparameter=%depositfolder%\%shortperiod%_%firstname%_%li%\%openfilename%
start "" %editor% %myparameter% 


:openview
if %openview%==0 goto openpause
set myparameter=%depositfolder%\%shortperiod%_%firstname%_%li%\%openfilename%
start "" %myparameter% 





:openpause
if %openpause%==0 goto namepile
rem pause with ping or spacebar here
if %openpause%==1 pause



:namepile
if %namepile%==0 goto openeverything
rem name pile, copy all student files in one combined folder, only works if students put name in file name
2>NUL copy %serversourcepath%         %depositfolder%\%period%   >NUL 
rem http://stackoverflow.com/questions/180741/how-to-do-something-to-each-file-in-a-directory-with-a-batch-script



:openeverything
if %openeverything%==0 goto end
for %%F in ( %depositfolder%\%shortperiod%_%firstname%_%li%\%openfilename%  ) do   (
    %%F 
    if %openpause%==1 pause
    )
if %namepile%==1 goto namepile
goto end




rem ==========================================================



:nofile
 
echo               %firstname% %id% noFile:%examplefile% 
echo no-file: %examplefile% in %prompt%       %date% %time% >> logs\%period%\%id%.txt
echo no-file: %examplefile% in %prompt%       %date% %time% >> logs\%period%\numeric\%privateid%.txt
echo no-file: %firstname% %lastname% %id% %serversourcepath%  >> logs\log_errors_%period%.txt
if %logstudents% == 1 echo .                                                      >> %studentbadreport%
if %logstudents% == 1 echo no-file: %examplefile% in %prompt%       %date% %time% >> %studentbadreport%


ping 127.0.0.1 -n %mydelay% > nul
 


goto end



:emptydir
del %templog%
echo     emptyFolder %firstname% %li%  %examplefile% 
echo empty folder: %prompt%       %date% %time% >> logs\%period%\%id%.txt
echo empty folder: %prompt%       %date% %time% >> logs\%period%\numeric\%privateid%.txt
echo empty folder: %firstname% %lastname% %id% %serversourcepath%  >> logs\log_errors_%period%.txt
if %logstudents% == 1 echo empty folder: %prompt%       %date% %time% >>   %studentbadreport%
ping 127.0.0.1 -n %mydelay% > nul
rem slight delay above
goto end


:nodir
echo          NoFolder %examplefile%  %firstname% %id%   
echo no-folder: %examplefile% in %prompt%       %date% %time% >> logs\%period%\%id%.txt
echo no-folder: %examplefile% in %prompt%       %date% %time% >> logs\%period%\numeric\%privateid%.txt
echo no-folder: %firstname% %lastname% %id% %serversourcepath%  >> logs\log_errors_%period%.txt
if %logstudents% == 1 echo no-folder: %examplefile% in %prompt%       %date% %time% >>    %studentbadreport%
ping 127.0.0.1 -n %mydelay% > nul
rem slight delay above
goto end





:cmderror
notepad %~nx0
rem syntax above is the file name being excuted
goto end



:end


rem keep these notes by joe
rem %var:~10,5% will extract 5 characters from position 10 in the environment variable %var%
rem %var:~-7% extracts the last 7 characters from %var%
rem %var:~0,-4% would extract all characters except the last four which would also rid you of the ext


rem for %%F in (F:\DB\*.xml) do (
rem    cmd 
rem  )
rem http://stackoverflow.com/questions/5642021/batch-process-all-files-in-directory


