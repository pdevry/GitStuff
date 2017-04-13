@echo off
if %1. == . goto cmderror
rem abort if no command line options


set depositfolder=%1
set period=%2
set serversourcepath=%prompt%


REM Make log folders
2>NUL md  logs
2>NUL md  logs\%period%
2>NUL md  logs\%period%\numeric


set serverlogspath="x:\CTE_STUDENTS\mr_rowe\NOTES_FEEDBACK\
if %logstudents% == 1 2>NUL md  %serverlogspath%%period%
rem if %logstudents% == 1 2>NUL md  %serverlogspath%%period%\your_data

rem feedback=1 
if %feedback% == 1 2>NUL md  %serverlogspath%%period%

rem old your_data folder
rem if %feedback% == 1 2>NUL md  %serverlogspath%%period%\your_data

 

rem make deposit folders
2>NUL md  %depositfolder%
2>NUL md  %depositfolder%\%period% 


REM date and time logs
time /t                                     		      			>> logs\log_errors_%period%.txt
date /t                        							>> logs\log_errors_%period%.txt
echo seeking  %serversourcepath% deposit:%depositfolder%  log:%logstudents%     >> logs\log_errors_%period%.txt


time /t                            		                		>> logs\log_ok_%period%.txt
date /t                            			        		>> logs\log_ok_%period%.txt
echo seeking %serversourcepath% deposit:%depositfolder%   log:%logstudents%     >> logs\log_ok_%period%.txt
goto end

:cmderror
echo.
echo no command line optins
echo.
pause



:end