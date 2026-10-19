$ErrorActionPreference = 'Stop'
$base = 'https://raw.githubusercontent.com/theuslpszbr15/rodar-deepseek/main'
$dir = Join-Path $env:LOCALAPPDATA 'rodar-deepseek'
New-Item -ItemType Directory -Force $dir | Out-Null

# RODAR_SRC é definido pelo install.cmd quando o repositório foi clonado.
if ($env:RODAR_SRC -and (Test-Path (Join-Path $env:RODAR_SRC 'rodar.cmd'))) {
    Copy-Item (Join-Path $env:RODAR_SRC 'rodar.cmd') $dir -Force
} else {
    Invoke-WebRequest "$base/rodar.cmd" -OutFile (Join-Path $dir 'rodar.cmd') -UseBasicParsing
}

$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
if (($userPath -split ';') -notcontains $dir) {
    [Environment]::SetEnvironmentVariable('Path', ($userPath.TrimEnd(';') + ';' + $dir), 'User')
}

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host 'Instalando Node.js (necessário para rodar)...'
        winget install --id OpenJS.NodeJS.LTS --exact --scope user --accept-package-agreements --accept-source-agreements
    } else {
        Write-Host 'Instale o Node.js LTS em https://nodejs.org e rode este instalador de novo.' -ForegroundColor Yellow
    }
}

Write-Host ''
Write-Host 'Pronto! Feche este terminal, abra um novo e digite:  rodar deepseek' -ForegroundColor Green
