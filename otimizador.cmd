@echo off

taskkill /im MAAB.RestApi.vshost.exe
taskkill /im MAAB.RestApi.exe


cls
echo Bem-vindo %USERNAME%, o que voce deseja?

FOR /D %%p IN ("C:\MaabDBs\*.*") DO rmdir "%%p" /s /q

mkdir C:\MaabDBs\Global
copy "%~dp0\MAAB.RestApi\MAAB.RestApi\ArquivosDefault\global.db" "C:\MaabDBs\Global\global.db"

C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe "%~dp0\MAAB.RestApi\MAAB.RestApi.sln" /property:Configuration=Debug /t:rebuild
start "API" "%~dp0\MAAB.RestApi\MAAB.RestApi\bin\Debug\MAAB.RestApi.exe"


echo ----------------------------[AGUARDANDO A API]-------------------------------

ping -n 10 127.0.0.1 > NUL

C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe "%~dp0\MAAB.TestesAceitacao\CargaDeDadosAPI\CargaDeDadosAPI.csproj" /property:Configuration=Debug /t:rebuild

start "Carga" "%~dp0\MAAB.TestesAceitacao\CargaDeDadosAPI\bin\Debug\CargaDeDadosAPI.exe"

chcp %cp%>nul