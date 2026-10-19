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

rem --celular: serve no IP da rede local (mesmo Wi-Fi) para abrir no celular.
if /i not "%~2"=="--celular" goto run
set "LANIP="
for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "(Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -and $_.NetAdapter.Status -eq 'Up' } | Select-Object -First 1).IPv4Address.IPAddress"`) do set "LANIP=%%I"
if not defined LANIP echo [rodar] Nao achei o IP da rede local. Conecte-se ao Wi-Fi e tente de novo.& exit /b 1
set "ARGS=--host %LANIP% --trusted-host %LANIP%:3080 --no-open %3 %4 %5 %6 %7 %8 %9"
echo [rodar] modo celular: aponte a camera do celular, no MESMO Wi-Fi, para o QR code que vai aparecer abaixo.
echo [rodar] Se o Windows pedir, permita o acesso em redes privadas. Use so em Wi-Fi de confianca ^(HTTP sem criptografia^).

:run
echo [rodar] iniciando DeepSeek Harness ^(Ctrl+C para parar^)
if defined LANIP goto runqr
npx.cmd --yes @deepseek-ai/dsh web %ARGS%
exit /b

:runqr
rem Repassa a saida do dsh e, ao ver a URL com token, mostra um QR code para a camera do celular.
npx.cmd --yes @deepseek-ai/dsh web %ARGS% 2>&1 | powershell -NoProfile -Command "$input | ForEach-Object { $_; if ($_ -match 'http://\S+token=\S+') { Write-Host ''; Write-Host 'Aponte a camera do celular para o QR code:'; $Matches[0] | npx.cmd --yes qrcode-terminal } }"
