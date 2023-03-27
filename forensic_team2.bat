@echo off
title FORENSIC_TEAM2
mode con cols=130 lines=20

echo.
echo.
echo    _______  _______  ______    _______  __    _  _______  ___   _______    _______  _______  _______  __   __    _______ 
echo " |       ||       ||    _ |  |       ||  |  | ||       ||   | |       |  |       ||       ||   _   ||  |_|  |  |       | "
echo " |    ___||   _   ||   | ||  |    ___||   |_| ||  _____||   | |       |  |_     _||    ___||  |_|  ||       |  |____   | "
echo " |   |___ |  | |  ||   |_||_ |   |___ |       || |_____ |   | |       |    |   |  |   |___ |       ||       |   ____|  | "
echo " |    ___||  |_|  ||    __  ||    ___||  _    ||_____  ||   | |      _|    |   |  |    ___||       ||       |  | ______| "
echo " |   |    |       ||   |  | ||   |___ | | |   | _____| ||   | |     |_     |   |  |   |___ |   _   || ||_|| |  | |_____  "
echo " |___|    |_______||___|  |_||_______||_|  |__||_______||___| |_______|    |___|  |_______||__| |__||_|   |_|  |_______| "                                                                                                                                                                                                                                                                                                                                      
echo.
echo                                                                       �̿���(����), ������, ������, ���, ����ȣ 
echo                                                                       ----------------------------------------------
echo                                                                                    %date% %time% - TEAM2                                                                    
echo.

:: path set
Set BASEPATH=.\team2_result
Set Tools=%BASEPATH%\..\Tools
set PASSWORD_PATH=.\password.txt

:: administrator privileges check
bcdedit >>nul 
if %errorlevel% == 1 (
echo Run with administrator privileges!
pause 
exit 
) 

::password input
set /p PASSWORD=[*] password? : 

::password.txt file pasing
set shell_cmd=type %PASSWORD_PATH%
FOR /F "tokens=*" %%F IN ('%shell_cmd%') DO (
SET PASSWORD_CHECK=%%F
)

::password check
if %PASSWORD% neq %PASSWORD_CHECK% (
echo password is wrong!!
pause 
exit 
) 

:: ExaminerName
Set ExaminerName="team2"

REM yyyymmdd set
:: Korea Windows
SET yyyymmdd=%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%
:: English Windows
:: SET yyyymmdd=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%

:: OS bit
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

:: Create Folder
if not exist %BASEPATH% (
mkdir %BASEPATH%
)

:: system time
date /T > %BASEPATH%\%yyyymmdd%_systemTime_%ExaminerName%.txt
time /T >> %BASEPATH%\%yyyymmdd%_systemTime_%ExaminerName%.txt


:MENU_LIST
cls
mode con cols=47 lines=28
echo.
echo ==============================================
echo.                                 
echo "   __     __   ______   _     _   _     _   "
echo "  (__) _ (__) (______) (_)   (_) (_)   (_)  "
echo "  (_) (_) (_) (_)__    (__)_ (_) (_)   (_)  "
echo "  (_) (_) (_) (____)   (_)(_)(_) (_)   (_)  "
echo "  (_)     (_) (_)____  (_)  (__) (_)___(_)  "
echo "  (_)     (_) (______) (_)   (_)  (_____)   "
echo.                                    
echo ==============================================
echo.   
echo 1. PC ����                                 
echo 2. ��Ʈ��ũ ����
echo 3. ���μ��� ���
echo 4. ���� ���� ����
echo 5. ���� ���
echo 6. ��ɾ� �����丮
echo 7. ���� ����
echo 8. ��� ���� ����
echo 0. ���α׷� ����
echo.
echo ==============================================
echo.
SET /P SELECT=��ȸ �ɼ� ���� : 
echo.
if %SELECT%==1 goto PC_START
if %SELECT%==2 goto NETWORK_START
if %SELECT%==3 goto PROCESS_START
if %SELECT%==4 goto REMOTE_START
if %SELECT%==5 goto SERVICE_START
if %SELECT%==6 goto HISTORY_START
if %SELECT%==7 goto COLOR_START
if %SELECT%==8 goto ALL_START
if %SELECT%==0 exit
if %SELECT% lss 0 goto MENU_LIST
if %SELECT% gtr 8 goto MENU_LIST

:PC_START
echo PC �̸� : %COMPUTERNAME% > %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
echo. >> %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
ver >> %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
echo. >> %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
net ACCOUNTS >> %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
echo. >> %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
set >> %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
echo. >> %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
net share >> %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
start %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
goto MENU_LIST


:NETWORK_START
cls
ECHO.                                    
ECHO ==============================================
ECHO.  
ECHO ��Ʈ��ũ �޴� ����
ECHO.                                    
ECHO ==============================================
ECHO.  
ECHO 1. ��Ʈ��ũ ���� ����
ECHO 2. ����� ���̺� ����
ECHO 3. ��Ʈ��ũ �������̽� ����
ECHO 4. �ݹ��̿��� ����
ECHO 5. ����� �������� ����
ECHO.
SET /P SELECT=��ȸ �ɼ� ���� : 
ECHO.

if %SELECT%==1 goto NETWORK_CONNECT
if %SELECT%==2 goto ROUTE_TABLE
if %SELECT%==3 goto NETWORK_INTERFACE
if %SELECT%==4 goto NET_BIOS
if %SELECT%==5 goto WIFI_INFO
if %SELECT% lss 1 goto MENU_LIST
if %SELECT% gtr 5 goto MENU_LIST


:NETWORK_CONNECT
cls
ECHO.                                    
ECHO ==============================================
ECHO.  
ECHO ��Ʈ��ũ ���� ����
ECHO.                                    
ECHO ==============================================
ECHO.  
ECHO 1. ��ü ��ȸ
ECHO 2. �������� ��ȸ: TCP 
ECHO 3. �������� ��ȸ: UDP 
ECHO 4. ���� ��ȸ: LISTENING
ECHO 5. ���� ��ȸ: ESTABLISHED
ECHO 6. ���� ��ȸ: CLOSE_WAIT
ECHO 7. ���� ��Ʈ Ȯ��
ECHO.
SET /P SELECT=��ȸ �ɼ� ���� : 

mode con cols=130 lines=35
IF %SELECT%==1 (
	netstat -nao > %BASEPATH%\%yyyymmdd%_networkInfo_%ExaminerName%.txt
	start %BASEPATH%\%yyyymmdd%_networkInfo_%ExaminerName%.txt
	goto NETWORK_END
)
IF %SELECT%==2 SET OPTION="TCP"
IF %SELECT%==3 SET OPTION="UDP"
IF %SELECT%==4 SET OPTION="LISTENING"
IF %SELECT%==5 SET OPTION="ESTABLISHED"
IF %SELECT%==6 SET OPTION="CLOSE_WAIT"
IF %SELECT%==7 (
	%Tools%\openports > %BASEPATH%\%yyyymmdd%_port_%ExaminerName%.txt
	start %BASEPATH%\%yyyymmdd%_port_%ExaminerName%.txt
	goto NETWORK_END
)
if %SELECT% lss 1 goto MENU_LIST
if %SELECT% gtr 7 goto MENU_LIST
netstat -nao|find/I %OPTION% > %BASEPATH%\%yyyymmdd%_network%OPTION%_%ExaminerName%.txt
start %BASEPATH%\%yyyymmdd%_network%OPTION%_%ExaminerName%.txt
goto NETWORK_END


:ROUTE_TABLE
mode con cols=130 lines=35
ECHO ����� ���̺�
netstat -r > %BASEPATH%\%yyyymmdd%_route_%ExaminerName%.txt
start %BASEPATH%\%yyyymmdd%_route_%ExaminerName%.txt
goto NETWORK_END


:NETWORK_INTERFACE
mode con cols=130 lines=35
ECHO ��Ʈ��ũ �������̽� ����
ECHO.                                    
ECHO ==============================================
ECHO.  
ECHO 1. ��ü ��ȸ
ECHO 2. IPv4 �ּ� ���
ECHO 3. IPv6 �ּ� ���
ECHO 4. ����� ����ũ ���
ECHO 5. ����Ʈ���� ���
ECHO.                                    
ECHO ==============================================
ECHO.  

SET /P SELECT=��ȸ �ɼ� ����:
IF %SELECT%==1 (
   ipconfig /all > %BASEPATH%\%yyyymmdd%_interface_%ExaminerName%.txt
   start %BASEPATH%\%yyyymmdd%_interface_%ExaminerName%.txt
   goto NETWORK_END
)
IF %SELECT%==2 SET OPTION="IPv4 �����"
IF %SELECT%==3 SET OPTION="IPv6 �����"
IF %SELECT%==4 SET OPTION="����� ����ũ �����"
IF %SELECT%==5 SET OPTION="����Ʈ���� �����"
if %SELECT% lss 1 goto MENU_LIST
if %SELECT% gtr 5 goto MENU_LIST
ipconfig|findstr /I %OPTION% > %BASEPATH%\%yyyymmdd%_interface_%OPTION%_%ExaminerName%.txt
start %BASEPATH%\%yyyymmdd%_interface_%OPTION%_%ExaminerName%.txt
goto NETWORK_END


:NET_BIOS
mode con cols=130 lines=35
ECHO �ݹ��̿��� ����
nbtstat -c > %BASEPATH%\%yyyymmdd%_netBIOS_%ExaminerName%.txt
start %BASEPATH%\%yyyymmdd%_netBIOS_%ExaminerName%.txt
goto NETWORK_END

:WIFI_INFO
mode con cols=130 lines=35
if not exist %BASEPATH%\WiFi_INFO (
	mkdir %BASEPATH%\WiFi_INFO
)
netsh wlan export profile folder=%BASEPATH%\WiFi_INFO key=clear
start %BASEPATH%\WiFi_INFO
goto NETWORK_END


:NETWORK_END
pause
cls
goto MENU_LIST


:PROCESS_START
mode con cols=130 lines=35
tasklist > %BASEPATH%\%yyyymmdd%_process_%ExaminerName%.txt
start %BASEPATH%\%yyyymmdd%_process_%ExaminerName%.txt

SET /P pInfoCheck=Ư�� ���μ����� �߰����� ������ Ȯ���Ͻðڽ��ϱ�? (y or n) : 
if %pInfoCheck%==y (
	cls
	ECHO.                                    
	ECHO ==============================================
	ECHO.  
	ECHO Ư�� ���μ����� �߰����� ���� Ȯ��
	ECHO.                                    
	ECHO ==============================================
	ECHO.  
	ECHO 1. ���̺귯�� ����
	ECHO 2. �ڵ� ����
	ECHO.
	SET /P pInfo=��ȸ �ɼ� ���� : 
)
if %pInfoCheck% neq y  goto PROCESS_END
if %pInfoCheck%==y SET /P PID=PID(���μ��� ID) �Է� : 
if %pInfo%==1 (
	%Tools%\listdlls %PID% > %BASEPATH%\%yyyymmdd%_PID_%PID%_library_%ExaminerName%.txt
	start %BASEPATH%\%yyyymmdd%_PID_%PID%_library_%ExaminerName%.txt
)
if %pInfo%==2 (
	%Tools%\handle -a %PID% > %BASEPATH%\%yyyymmdd%_PID_%PID%_handle_%ExaminerName%.txt
	start %BASEPATH%\%yyyymmdd%_PID_%PID%_handle_%ExaminerName%.txt
)
:PROCESS_END
pause
cls
goto MENU_LIST


:REMOTE_START
mode con cols=130 lines=35
net session  > %BASEPATH%\%yyyymmdd%_remoteInfo_%ExaminerName%.txt
openfiles >> %BASEPATH%\%yyyymmdd%_remoteInfo_%ExaminerName%.txt
start %BASEPATH%\%yyyymmdd%_remoteInfo_%ExaminerName%.txt
pause
cls
goto MENU_LIST


:SERVICE_START
cls
ECHO.                                    
ECHO ==============================================
ECHO.  
ECHO ���� ���
ECHO.                                    
ECHO ==============================================
ECHO. 
ECHO.  
echo 1. ������ ���� ��� ����
echo 2. ����� �۾� Ȯ��
echo 3. ���� ���α׷� ���
ECHO.
SET /P SELECT=��ȸ �ɼ� ���� :

if %SELECT%==1 goto PSSERVICE_START
if %SELECT%==2 goto SCHTASKS_START
if %SELECT%==3 goto AUTORUNSC_START
if %SELECT% lss 1 goto MENU_LIST
if %SELECT% gtr 3 goto MENU_LIST


:PSSERVICE_START
cls
ECHO.                                    
ECHO ==============================================
ECHO.  
ECHO ������ ���� ��� ����
ECHO.                                    
ECHO ==============================================
ECHO. 
ECHO.  
echo 1. �̸��� ���
echo 2. ��ü ���� ���
ECHO.
SET /P SELECT=��ȸ �ɼ� ���� :

mode con cols=130 lines=35
if %SELECT%==1 (
	%Tools%\psservice | findstr SERVICE_NAME: > %BASEPATH%\%yyyymmdd%_servicesName_%ExaminerName%.txt
	start %BASEPATH%\%yyyymmdd%_servicesName_%ExaminerName%.txt
)
if %SELECT%==2 (
	%Tools%\psservice > %BASEPATH%\%yyyymmdd%_services_%ExaminerName%.txt
	start %BASEPATH%\%yyyymmdd%_services_%ExaminerName%.txt
)
if %SELECT% lss 1 goto MENU_LIST
if %SELECT% gtr 2 goto MENU_LIST
goto SERVICE_END


:SCHTASKS_START
mode con cols=130 lines=35
schtasks > %BASEPATH%\%yyyymmdd%_scheduledTasks_%ExaminerName%.txt
start %BASEPATH%\%yyyymmdd%_scheduledTasks_%ExaminerName%.txt
goto SERVICE_END


:AUTORUNSC_START
mode con cols=130 lines=35
%Tools%\autorunsc > %BASEPATH%\%yyyymmdd%_startupPrograms_%ExaminerName%.txt
start %BASEPATH%\%yyyymmdd%_startupPrograms_%ExaminerName%.txt
goto SERVICE_END


:SERVICE_END
pause
cls
goto MENU_LIST


:HISTORY_START
mode con cols=130 lines=35
doskey/history > %BASEPATH%\%yyyymmdd%_history_%ExaminerName%.txt
start %BASEPATH%\%yyyymmdd%_history_%ExaminerName%.txt
pause
cls
goto MENU_LIST


:COLOR_START
cls
ECHO.                                    
ECHO ==============================================
echo ������ �� ���                                   
ECHO ==============================================
echo ��õ�� [����, ���ڻ�]
echo ������� : [02, 09, 0A, 0C, 0E]
echo ������ : [F0, F1, F2, F4] 
ECHO ==============================================
ECHO. 
echo 0=������      8=ȸ��
echo 1=�Ķ���      9=���� �Ķ���
echo 2=�ʷϻ�      A=���� �ʷϻ�
echo 3=����        B=���� ����
echo 4=������      C=���� ������
echo 5=���ֻ�      D=���� ���ֻ�
echo 6=�����      E=���� �����
echo 7=���        F=���� ���
ECHO.                                    
ECHO ==============================================
ECHO. 
set /p select=�� ������ ���Ͻó���? (y or n) : 
if %select%==n goto MENU_LIST
if %select%==y (
   set /p bgcolor=������ ���� �Է�:
   set /p textcolor=������ ���ڻ� �Է�:
)
color %bgcolor%%textcolor%
pause
cls
goto MENU_LIST


:ALL_START
mode con cols=130 lines=35
echo PC �̸� : %COMPUTERNAME% > %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
echo. >> %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
ver >> %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
echo. >> %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
net ACCOUNTS >> %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
echo. >> %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
set >> %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
echo. >> %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
net share >> %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
netstat -nao > %BASEPATH%\%yyyymmdd%_networkInfo_%ExaminerName%.txt
netstat -r > %BASEPATH%\%yyyymmdd%_route_%ExaminerName%.txt
ipconfig /all > %BASEPATH%\%yyyymmdd%_interface_%ExaminerName%.txt
nbtstat -c > %BASEPATH%\%yyyymmdd%_netBIOS_%ExaminerName%.txt
tasklist > %BASEPATH%\%yyyymmdd%_process_%ExaminerName%.txt
schtasks > %BASEPATH%\%yyyymmdd%_scheduledTasks_%ExaminerName%.txt
%Tools%\autorunsc > %BASEPATH%\%yyyymmdd%_startupPrograms_%ExaminerName%.txt
net session  > %BASEPATH%\%yyyymmdd%_remoteInfo_%ExaminerName%.txt
openfiles > %BASEPATH%\%yyyymmdd%_openFile_%ExaminerName%.txt
%Tools%\psservice > %BASEPATH%\%yyyymmdd%_services_%ExaminerName%.txt
%Tools%\handle -a > %BASEPATH%\%yyyymmdd%_handle_%ExaminerName%.txt
%Tools%\listdlls > %BASEPATH%\%yyyymmdd%_library_%ExaminerName%.txt
doskey/history > %BASEPATH%\%yyyymmdd%_history_%ExaminerName%.txt
echo.
ECHO ==============================================
echo.
echo ��� ���� ���� �Ϸ�
echo ��� : %BASEPATH%
echo.
ECHO ==============================================
start %BASEPATH%
pause 
cls
goto MENU_LIST