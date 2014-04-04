@echo off
taskkill /F /im ExecutadorDeProcessosEmFila.exe
taskkill /F /im ExecutadorDeObservadoresEmFila.exe
taskkill /F /im MAAB.RestApi.exe
taskkill /F /im MAAB.RestApi.vshost.exe
taskkill /F /im MAAB.MQ.exe

 
C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe "%~dp0\MAAB.RestApi\MAAB.RestApi.sln" /t:Rebuild /p:Configuration=Debug
C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe "%~dp0\MAAB.TestesAceitacao\CargaDeDadosAPI\CargaDeDadosAPI.csproj" /t:Rebuild /p:Configuration=Debug
 
FOR /D %%p IN ("C:\MaabDBs\*.*") DO rmdir "%%p" /s /q
 
mkdir C:\MaabDBs\Global
 
copy "%~dp0\MAAB.RestApi\MAAB.RestApi\ArquivosDefault\global.db" "C:\MaabDBs\Global\global.db"
 
D:
 
cd "%~dp0\MAAB.RestApi\MAAB.RestApi\bin\Debug" 

start "MAAB.RestApi" "%~dp0\MAAB.RestApi\MAAB.RestApi\bin\Debug\MAAB.RestApi.exe"
 
cd "%~dp0\MAAB.TestesAceitacao\CargaDeDadosAPI\bin\Debug" 
start "Carga de dados" "%~dp0\MAAB.TestesAceitacao\CargaDeDadosAPI\bin\Debug\CargaDeDadosAPI.exe"
 
taskkill /F /im ExecutadorDeProcessosEmFila.exe
taskkill /F /im ExecutadorDeObservadoresEmFila.exe
taskkill /F /im MAAB.RestApi.exe

cd "%~dp0\MAAB.RestApi\MAAB.RestApi\bin\Debug"
start "MAAB.RestApi" "%~dp0\MAAB.RestApi\MAAB.RestApi\bin\Debug\MAAB.RestApi.exe"