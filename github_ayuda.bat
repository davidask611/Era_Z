@echo off
setlocal EnableDelayedExpansion
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
if errorlevel 1 (
  echo.
  echo ERROR al bajar. Revisa tu conexion o autenticacion.
) else (
  echo.
  echo OK: Bajada completada.
)
echo.
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
echo [A] Archivos detectados (probar_IA.ps1 queda siempre fuera):
git status --short
echo.
set "msg="
set /p "msg=Mensaje del commit (Enter = Actualizacion): "
if "!msg!"=="" set "msg=Actualizacion"
echo.

echo [B] Agregando archivos...
git add -A
if errorlevel 1 (
  echo ERROR al agregar archivos.
  goto push_result
)

git diff --cached --quiet
if !errorlevel! equ 0 (
  echo No habia cambios nuevos para subir.
  goto push_result
)

echo [C] Creando commit...
git commit -m "!msg!"
if errorlevel 1 (
  echo ERROR al crear el commit.
  goto push_result
)

echo [D] Subiendo a GitHub...
git push
if errorlevel 1 (
  echo ERROR al subir. Revisa autenticacion.
  goto push_result
)

:push_result
set "PEND=0"
for /f "delims=" %%L in ('git status --porcelain') do set "PEND=1"
echo.
if "!PEND!"=="1" (
  echo AVISO: Todavia quedan cambios que NO se subieron:
  git status --short
) else (
  echo OK: Todo quedo sincronizado con GitHub.
)
echo.
pause >nul
goto menu

:end
endlocal
exit /b 0
