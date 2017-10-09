 ECHO OFF
TITLE CORE 2.0
mode con:cols=100 lines=35
:-------------------------------------
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    call :c 0a " Requesting administrative privileges... " /n
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
for /f "tokens=2 delims==" %%f in ('wmic cpu get name /value ^| find "="') do set "name=%%f" 
for /f "tokens=2 delims==" %%f in ('wmic os get caption /value ^| find "="') do set "OS=%%f" 
for /f "tokens=2 delims==" %%f in ('wmic bios get SMBIOSBIOSVersion /value ^| find "="') do set "BIOS=%%f" 
for /f "tokens=2 delims==" %%f in ('wmic IDECONTROLLER get Caption /value ^| find "="') do set "IDE=%%f" 
:MENU
echo Version Bios %bios% >> %USERPROFILE%\Desktop\RELATORIO.txt
CLS
call :c 0a "  //--------------------CORE Version 2.0-------------------------------\\    " /n
call :c 0a " --"
call :c 05 "                    / ____// __ \ / __ \ / ____/                        "
call :c 0a "--  " /n
call :c 0a " --"
call :c 05 "                   / /    / / / // /_/ // __/                           "
call :c 0a "--  " /n
call :c 0a " --"
call :c 05 "                  / /___ / /_/ // _, _// /___                           " 
call :c 0a "--  " /n
call :c 0a "  \\-------------"
call :c 05 "    \____/ \____//_/ |_|/_____/   "
call :c 0a "----------------------//    " /n
call :c 0a "   \\-----
call :c 05 " Tech resolution Slow Performance"
call :c 0a " - Creator:MATHEUS BENITES  -//     " /n
ECHO.
call :c 0F " _____________________________________________________________" /n
call :c 07 "BIOS Version"
call :c 0a " %bios%" /n
echo %name%
echo %OS%
systeminfo | findstr "total"
call :c 0F "\             SELECIONE Memoria fisica total                     \" /n
call :c 0F " \_______________________________________________________________,  " /n
ECHO.
ECHO 2 - Memoria Fisica para 2GB
ECHO 4 - Memoria Fisica para 4GB
ECHO 6 - Memoria Fisica para 6GB
ECHO 8 - Memoria Fisica para 8GB
ECHO 0 - PULAR ETAPA
ECHO.
SET /P M=Pressione a Chave e ENTER:
IF %M%==2 GOTO 2GB
IF %M%==4 GOTO 4GB
IF %M%==6 GOTO 6GB
IF %M%==8 GOTO 8GB
IF %M%==0 GOTO SERVICO
goto MENU
                :2GB
wmic pagefileset create name="C:\pagefile.sys"
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=2048,MaximumSize=4096
ECHO Otimizado Memoria Virtual da Paginacao para 2048 mb  >> %USERPROFILE%\Desktop\RELATORIO.txt
goto SERVICO
                :4GB
wmic pagefileset create name="C:\pagefile.sys"
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=4096,MaximumSize=6144
ECHO Otimizado Memoria Virtual da Paginacao para 4096 mb  >> %USERPROFILE%\Desktop\RELATORIO.txt
goto SERVICO
                :6GB
wmic pagefileset create name="C:\pagefile.sys"
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=6144,MaximumSize=8192
ECHO Otimizado Memoria Virtual da Paginacao para 6144 mb  >> %USERPROFILE%\Desktop\RELATORIO.txt
goto SERVICO
                :8GB
wmic pagefileset create name="C:\pagefile.sys"
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=8192,MaximumSize=10124
ECHO Otimizado Memoria Virtual da Paginacao para 8192 mb  >> %USERPROFILE%\Desktop\RELATORIO.txt
goto SERVICO

                :SERVICO
sc config SysMain start= disabled 
sc failureflag SysMain flag=0 
sc failure SysMain  reset= 3 actions= /0 
        net stop SysMain    
        call :c 0a "[Desabilitado Superfetch]" /n 
ECHO DESABILITADO Superfetch >> %USERPROFILE%\Desktop\RELATORIO.txt
timeout /t 1 /nobreak > nul

sc config DiagTrack start= disabled
sc failureflag DiagTrack flag=0
sc failure DiagTrack reset=3 actions= /0
        net     stop DiagTrack
        call :c 0a "[Desativado Telemetria]" /n 
ECHO DESABILITADO Experiencias e Telemetria de Usuario Conectado >> %USERPROFILE%\Desktop\RELATORIO.txt
timeout /t 1 /nobreak > nul

sc config BITS start= disabled 
sc failureflag BITS flag=0 
sc failure BITS  reset= 3 actions= /0 
        net stop BITS 
        call :c 0a "[Desativado transferencia inteligente de tela de fundo]" /n 
ECHO DESABILITADO Servico de transferencia inteligente de tela de fundo >> %USERPROFILE%\Desktop\RELATORIO.txt
timeout /t 1 /nobreak > nul

schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /DISABLE
schtasks /Delete /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /F
        call :c 0a "[Desativado StartupAppTask]" /n 
                timeout /t 1 /nobreak > nul
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /DISABLE
schtasks /Delete /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /F
        call :c 0a "[Desativado ProgramDataUpdater]" /n 
                timeout /t 1 /nobreak > nul
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /DISABLE
schtasks /Delete /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /F
        call :c 0a "[Desativado Microsoft Compatibility Appraiser]" /n 
                timeout /t 1 /nobreak > nul
ECHO DESATIVADO Agendador de Tarefas Experience Telemetria >> %USERPROFILE%\Desktop\RELATORIO.txt
schtasks /change /tn "\Microsoft\Windows\TaskScheduler\Maintenance Configurator" /DISABLE
schtasks /Delete /tn "\Microsoft\Windows\TaskScheduler\Maintenance Configurator" /F
ECHO DESATIVADO Manutencao automatica >> %USERPROFILE%\Desktop\RELATORIO.txt
        call :c 0a "[Manutencao Automatica]" /n 
        timeout /t 1 /nobreak > nul
        
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
ECHO DESATIVADO Telemetry regedit >> %USERPROFILE%\Desktop\RELATORIO.txt
        call :c 0a "[AllowTelemetry Desativado]" /n
        timeout /t 1 /nobreak > nul
call :c 0a "[Configurado politicas de energia]" /n
powercfg -x -disk-timeout-ac 0
powercfg -x -disk-timeout-dc 0
powercfg -x -standby-timeout-ac 0
powercfg -x -standby-timeout-dc 0
powercfg -x -hibernate-timeout-ac 0
powercfg -x -hibernate-timeout-dc 0
ECHO Configurado politicas de energia sem Hibernacao  >> %USERPROFILE%\Desktop\RELATORIO.txt
timeout /t 1 /nobreak > nul
        
        RunDll32.exe inetcpl.cpl , ClearMyTracksByProcess 255
call :c 0a "[Realizado Limpeza de dados web]" /n 
ECHO Limpeza de dados web - Cookies - Dados do filtro de phishing >> %USERPROFILE%\Desktop\RELATORIO.txt
timeout /t 1 /nobreak > nul
GOTO CORE
                :CORE 
CLS
for /f "tokens=2 delims==" %%f in ('wmic cpu get NumberOfLogicalProcessors /value ^| find "="') do set "CPU=%%f" (
ECHO Otimizado Nucleos na inicializacao para %CPU%  nucleos >> %USERPROFILE%\Desktop\RELATORIO.txt
bcdedit /set numproc %CPU%
cls
echo Otimizando nucleos apartir bcdedit...
timeout /t 1 /nobreak > nul
call :c 0a " [Processamento Otimizado Na inicializaçao para %CPU% Nucleos] " /n 
)
timeout /t 3 /nobreak > nul
GOTO CACHE
                :CACHE
for /f "tokens=2 delims==" %%f in ('wmic cpu get l2cachesize /value ^| find "="') do set "L2=%%f" (
ECHO Otimizando L2 Cache para %L2% kb >> %USERPROFILE%\Desktop\RELATORIO.txt
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v SecondLevelDataCache /t REG_DWORD /d %L2% /f
cls
echo Otimizado L2 Cache Do Processador...
timeout /t 1 /nobreak > nul
call :c 0a " [L2 Cache Configurado Para %L2% Kb ]" /n 
)
timeout /t 3 /nobreak > nul
GOTO SERIAL ATA
				:SERIAL ATA
for /F "skip=1" %%i in ('wmic IDECONTROLLER GET DeviceID') do (
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v MSISupported /t REG_DWORD /d 0 /f
)
cls
echo Corrigindo Serial ATA Controller...
ECHO Desativado MSISupported no - %IDE%  >> %USERPROFILE%\Desktop\RELATORIO.txt
timeout /t 1 /nobreak > nul
call :c 0a " [Configurado %IDE% ]" /n 
GOTO FIM
                :FIM
GPUPDATE/FORCE
ECHO Realizado Gpupdate/force >> %USERPROFILE%\Desktop\RELATORIO.txt
call :c 0a "[GPUPDATE/FORCE]" /n
timeout /t 1 /nobreak > nul
call :c 0a "[Fix complete]" /n 
timeout /t 3 /nobreak > nul
CLS
ECHO Verificando.
call :c 0a "[/]"
call :c 0c "Exit 3 segundos" /n 
timeout /t 1 /nobreak > nul
CLS
ECHO Verificando.. 
call :c 0a "[\]"
call :c 0c "Exit 2 segundos" /n 
timeout /t 1 /nobreak > nul
CLS
ECHO Verificando...
call :c 0a "[/]"  
call :c 0c "Exit 1 segundos" /n 
timeout /t 1 /nobreak > nul
del %appdata%\CORE.bat
del %appdata%\decore.hex
exit
:c
setlocal enableDelayedExpansion
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:colorPrint Color  Str  [/n]
setlocal
set "s=%~2"
call :colorPrintVar %1 s %3
exit /b

:colorPrintVar  Color  StrVar  [/n]
if not defined DEL call :initColorPrint
setlocal enableDelayedExpansion
pushd .
':
cd \
set "s=!%~2!"
for %%n in (^"^

^") do (
  set "s=!s:\=%%~n\%%~n!"
  set "s=!s:/=%%~n/%%~n!"
  set "s=!s::=%%~n:%%~n!"
)
for /f delims^=^ eol^= %%s in ("!s!") do (
  if "!" equ "" setlocal disableDelayedExpansion
  if %%s==\ (
    findstr /a:%~1 "." "\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%"
  ) else if %%s==/ (
    findstr /a:%~1 "." "/.\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%"
  ) else (
    >colorPrint.txt (echo %%s\..\')
    findstr /a:%~1 /f:colorPrint.txt "."
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
  )
)
if /i "%~3"=="/n" echo(
popd
exit /b


:initColorPrint
for /f %%A in ('"prompt $H&for %%B in (1) do rem"') do set "DEL=%%A %%A"
<nul >"%temp%\'" set /p "=."
subst ': "%temp%" >nul
exit /b