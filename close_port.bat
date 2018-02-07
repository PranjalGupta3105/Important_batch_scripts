@echo off

setlocal enabledelayedexpansion

set /p port_no="Enter the port no to display the details :"

pause

echo %port_no%

pause

netstat -ano| findstr :%port_no%

echo "If you find any process id that is accessing your port please feed to the script below: " 

pause

set /p option="Press 1 if there exists a process that is occuping your port else press 0 BELOW :"

pause

IF %option% EQU 1 (

echo " So what is the process id that is blocking tcp.."

set /p prcs_id="Enter the process id of the process you want to terminate :"

pause

echo I got the process id: !prcs_id!

pause 

taskkill /PID !prcs_id! /F

pause 

echo Terminated the process ...

) else (

exit

)
