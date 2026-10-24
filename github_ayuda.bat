@echo off
setlocal
cd /d "%~dp0"
title Era_Z - Ayuda GitHub

:menu
cls
echo ==============================
echo  ERA_Z  -  AYUDA GITHUB
echo ==============================
echo.
echo 1) Bajar cambios (git pull)
echo 2) Subir cambios (git add + commit + push)
echo 3) Ver estado (git status)
echo 4) Salir
echo.
set /p "op=Seleccione opcion (1-4): "
if "%op%"=="1" goto pull
if "%op%"=="2" goto push
if "%op%"=="3" goto status
if "%op%"=="4" goto end
goto menu

:pull
echo.
echo [1] Descargando cambios de origin/main...
git pull
echo.
echo Listo. Presione una tecla para volver al menu.
pause >nul
goto menu

:status
echo.
git status
echo.
pause >nul
goto menu

:push
echo.
echo [A] Archivos que se van a subir (excepto probar_IA.ps1):
git status --short
echo.
set "msg="
set /p "msg=Mensaje del commit (Enter = Actualizacion): "
if "%msg%"=="" set "msg=Actualizacion"
echo.
echo [B] Agregando archivos...
git add .
echo [C] Creando commit...
git commit -m "%msg%"
echo [D] Subiendo a GitHub...
git push
echo.
echo Listo. Presione una tecla para volver al menu.
pause >nul
goto menu

:end
endlocal
exit /b 0
