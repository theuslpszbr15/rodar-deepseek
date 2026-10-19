@echo off
setlocal
if /i "%~1"=="deepseek" goto deepseek
echo Uso: rodar deepseek [opcoes do "dsh web", ex.: --no-open]
exit /b 1

:deepseek
where node >nul 2>&1 || (echo Node.js nao encontrado. Instale em https://nodejs.org ^(versao 22.19+ ou 24+^) & exit /b 1)

powershell -NoProfile -Command "if(Get-NetTCPConnection -LocalPort 3080 -State Listen -ErrorAction SilentlyContinue){exit 1}" || (
  echo [rodar] A porta 3080 ja esta em uso: o DeepSeek Harness provavelmente ja esta rodando.
  echo         Use a URL com token impressa no terminal que o iniciou, ou feche-o e rode de novo.
  exit /b 1
)

rem Proxy: usa o do sistema (PAC/WinHTTP) quando existir, sem hardcode.
if not defined HTTPS_PROXY for /f "usebackq delims=" %%P in (`powershell -NoProfile -Command "$u=[uri]'https://api.deepseek.com'; $p=[Net.WebRequest]::GetSystemWebProxy().GetProxy($u); if($p.Host -ne $u.Host){$p.AbsoluteUri}"`) do set "HTTPS_PROXY=%%P"
if defined HTTPS_PROXY (
  set "HTTP_PROXY=%HTTPS_PROXY%"
  set "NODE_OPTIONS=--use-env-proxy --use-system-ca"
  echo [rodar] proxy: %HTTPS_PROXY%
)

rem Fora de pastas com workspace local, o npx nao acha o binario "dsh".
cd /d "%USERPROFILE%"
set "ARGS=%2 %3 %4 %5 %6 %7 %8 %9"
echo [rodar] iniciando DeepSeek Harness ^(Ctrl+C para parar^)
npx.cmd --yes @deepseek-ai/dsh web %ARGS%
