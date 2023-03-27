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
echo                                                                       이예준(조장), 김찬욱, 송태현, 어영민, 이정호 
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
echo 1. PC 정보                                 
echo 2. 네트워크 정보
echo 3. 프로세스 목록
echo 4. 원격 접속 정보
echo 5. 서비스 목록
echo 6. 명령어 히스토리
echo 7. 색상 변경
echo 8. 모든 정보 수집
echo 0. 프로그램 종료
echo.
echo ==============================================
echo.
SET /P SELECT=조회 옵션 선택 : 
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
echo PC 이름 : %COMPUTERNAME% > %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
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
ECHO 네트워크 메뉴 선택
ECHO.                                    
ECHO ==============================================
ECHO.  
ECHO 1. 네트워크 연결 정보
ECHO 2. 라우팅 테이블 정보
ECHO 3. 네트워크 인터페이스 정보
ECHO 4. 넷바이오스 정보
ECHO 5. 저장된 와이파이 정보
ECHO.
SET /P SELECT=조회 옵션 선택 : 
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
ECHO 네트워크 연결 정보
ECHO.                                    
ECHO ==============================================
ECHO.  
ECHO 1. 전체 조회
ECHO 2. 프로토콜 조회: TCP 
ECHO 3. 프로토콜 조회: UDP 
ECHO 4. 상태 조회: LISTENING
ECHO 5. 상태 조회: ESTABLISHED
ECHO 6. 상태 조회: CLOSE_WAIT
ECHO 7. 열린 포트 확인
ECHO.
SET /P SELECT=조회 옵션 선택 : 

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
ECHO 라우팅 테이블
netstat -r > %BASEPATH%\%yyyymmdd%_route_%ExaminerName%.txt
start %BASEPATH%\%yyyymmdd%_route_%ExaminerName%.txt
goto NETWORK_END


:NETWORK_INTERFACE
mode con cols=130 lines=35
ECHO 네트워크 인터페이스 정보
ECHO.                                    
ECHO ==============================================
ECHO.  
ECHO 1. 전체 조회
ECHO 2. IPv4 주소 출력
ECHO 3. IPv6 주소 출력
ECHO 4. 서브넷 마스크 출력
ECHO 5. 게이트웨이 출력
ECHO.                                    
ECHO ==============================================
ECHO.  

SET /P SELECT=조회 옵션 선택:
IF %SELECT%==1 (
   ipconfig /all > %BASEPATH%\%yyyymmdd%_interface_%ExaminerName%.txt
   start %BASEPATH%\%yyyymmdd%_interface_%ExaminerName%.txt
   goto NETWORK_END
)
IF %SELECT%==2 SET OPTION="IPv4 어댑터"
IF %SELECT%==3 SET OPTION="IPv6 어댑터"
IF %SELECT%==4 SET OPTION="서브넷 마스크 어댑터"
IF %SELECT%==5 SET OPTION="게이트웨이 어댑터"
if %SELECT% lss 1 goto MENU_LIST
if %SELECT% gtr 5 goto MENU_LIST
ipconfig|findstr /I %OPTION% > %BASEPATH%\%yyyymmdd%_interface_%OPTION%_%ExaminerName%.txt
start %BASEPATH%\%yyyymmdd%_interface_%OPTION%_%ExaminerName%.txt
goto NETWORK_END


:NET_BIOS
mode con cols=130 lines=35
ECHO 넷바이오스 정보
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

SET /P pInfoCheck=특정 프로세스의 추가적인 정보를 확인하시겠습니까? (y or n) : 
if %pInfoCheck%==y (
	cls
	ECHO.                                    
	ECHO ==============================================
	ECHO.  
	ECHO 특정 프로세스의 추가적인 정보 확인
	ECHO.                                    
	ECHO ==============================================
	ECHO.  
	ECHO 1. 라이브러리 정보
	ECHO 2. 핸들 정보
	ECHO.
	SET /P pInfo=조회 옵션 선택 : 
)
if %pInfoCheck% neq y  goto PROCESS_END
if %pInfoCheck%==y SET /P PID=PID(프로세스 ID) 입력 : 
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
ECHO 서비스 목록
ECHO.                                    
ECHO ==============================================
ECHO. 
ECHO.  
echo 1. 윈도우 서비스 목록 정보
echo 2. 예약된 작업 확인
echo 3. 시작 프로그램 목록
ECHO.
SET /P SELECT=조회 옵션 선택 :

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
ECHO 윈도우 서비스 목록 정보
ECHO.                                    
ECHO ==============================================
ECHO. 
ECHO.  
echo 1. 이름만 출력
echo 2. 전체 내용 출력
ECHO.
SET /P SELECT=조회 옵션 선택 :

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
echo 변경할 색 목록                                   
ECHO ==============================================
echo 추천색 [배경색, 글자색]
echo 검정배경 : [02, 09, 0A, 0C, 0E]
echo 흰색배경 : [F0, F1, F2, F4] 
ECHO ==============================================
ECHO. 
echo 0=검정색      8=회색
echo 1=파랑색      9=연한 파랑색
echo 2=초록색      A=연한 초록색
echo 3=옥색        B=연한 옥색
echo 4=빨강색      C=연한 빨강색
echo 5=자주색      D=연한 자주색
echo 6=노랑색      E=연한 노랑색
echo 7=흰색        F=밝은 흰색
ECHO.                                    
ECHO ==============================================
ECHO. 
set /p select=색 변경을 원하시나요? (y or n) : 
if %select%==n goto MENU_LIST
if %select%==y (
   set /p bgcolor=변경할 배경색 입력:
   set /p textcolor=변경할 글자색 입력:
)
color %bgcolor%%textcolor%
pause
cls
goto MENU_LIST


:ALL_START
mode con cols=130 lines=35
echo PC 이름 : %COMPUTERNAME% > %BASEPATH%\%yyyymmdd%_PCinfo_%ExaminerName%.txt
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
echo 모든 파일 저장 완료
echo 경로 : %BASEPATH%
echo.
ECHO ==============================================
start %BASEPATH%
pause 
cls
goto MENU_LIST