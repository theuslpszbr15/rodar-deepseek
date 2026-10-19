@echo off
rem Adiciona esta pasta ao PATH do usuario para o comando "rodar" funcionar em qualquer lugar.
set "DIR=%~dp0"
if "%DIR:~-1%"=="\" set "DIR=%DIR:~0,-1%"
powershell -NoProfile -Command "$d=$env:DIR; $p=[Environment]::GetEnvironmentVariable('Path','User'); if(($p -split ';') -notcontains $d){[Environment]::SetEnvironmentVariable('Path',($p.TrimEnd(';')+';'+$d),'User'); 'Adicionado ao PATH: '+$d}else{'Ja estava no PATH.'}"
echo Abra um NOVO terminal e rode: rodar deepseek
