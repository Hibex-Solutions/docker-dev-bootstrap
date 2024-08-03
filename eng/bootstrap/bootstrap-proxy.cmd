:: Copyright (c) Erlimar Silva Campos. All rights reserved.
:: This file is a part of TheCleanArch.
:: Licensed under the Apache version 2.0: LICENSE file.

@echo off

docker version >nul 2>nul
if %errorlevel% neq 0 (
  echo wrn: O Docker parece não estar instalado!
  goto :error
)

docker compose version >nul 2>nul
if %errorlevel% neq 0 (
  echo wrn: O Docker Compose parece não estar instalado!
  goto :error
)

if "%PROJECT_IMAGE_TAG%" == "" (
  echo wrn: É necessário definir a variável de ambiente PROJECT_IMAGE_TAG
  goto :error
)

set DOCKER_IMAGE_TAG=%PROJECT_IMAGE_TAG%-bootstrap
set TEMPFILE_LOG=%TEMP%\%PROJECT_NAME%~%RANDOM%~%RANDOM%.log

docker images | findstr %DOCKER_IMAGE_TAG% >nul 2>nul
rem Intercepta o argumento "--cleanup-bootstrap" para limpar
rem recursos de bootstrap locais

for %%a in (%*) do (
  if "%%a" == "--cleanup-bootstrap" goto :cleanup
)
if %errorlevel% neq 0 (
  echo inf: Gerando imagem Docker...
  docker build -t %DOCKER_IMAGE_TAG% -f %~dp0Dockerfile %~dp0 > %TEMPFILE_LOG% 2>&1
)

docker images | findstr %DOCKER_IMAGE_TAG% >nul 2>nul
if %errorlevel% neq 0 (
  echo wrn: Falha ao gerar imagem Docker!
  echo wrn: Mais detalhes no arquivo de log %TEMPFILE_LOG%
  goto :error
)

docker run --volume %~dp0\..\..:/root:rw %DOCKER_IMAGE_TAG% %* 

goto :end

:cleanup
echo inf: Limpando recursos bootstrap...
docker container prune -f
if %errorlevel% neq 0 (
  echo wrn: Falha ao limpar containers parados!
  goto :error
)

docker rmi "%DOCKER_IMAGE_TAG%"
if %errorlevel% neq 0 (
  echo wrn: Falha ao limpar imagens de bootstrap!
  goto :error
)

echo inf: Recursos de boostrap removidos
goto :end

:error
echo err: Falha na execução do script. Resolva as pendências e tente novamente

:end
