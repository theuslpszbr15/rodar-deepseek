@echo off
rem Instalador para quem clonou o repositorio; usa o rodar.cmd desta pasta.
set "RODAR_SRC=%~dp0"
powershell -NoProfile -Command "Get-Content -Raw '%~dp0install.ps1' | Invoke-Expression"
