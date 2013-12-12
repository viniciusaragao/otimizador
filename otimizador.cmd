@echo off

taskkill /im MAAB.RestApi.vshost.exe
taskkill /im MAAB.RestApi.exe

setx PATH "%PATH%;%ProgramFiles%\MySQL\MySQL Server 5.5\bin"

cls
echo Bem-vindo %USERNAME%, o que voce deseja?
echo ....
echo .... Para mais de um convenio, separe os numero com espaco
echo .... Para todos nao digite nada, apenas tecle ENTER
echo ....
echo 0     - PLANJUS
echo 1     - ABEPOM
echo 2     - MONGERAL
echo 3     - JUSPREV
echo ENTER - TODOS

set /p Convenio=Digite os diretorios a ser carregado:%=%


FOR /D %%p IN ("C:\MaabDBs\*.*") DO rmdir "%%p" /s /q

mkdir C:\MaabDBs\Global
copy "C:\Users\%USERNAME%\Documents\GitHub\Vital\MAAB.RestApi\MAAB.RestApi\ArquivosDefault\global.db" "C:\MaabDBs\Global\global.db"

C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe "C:\Users\%USERNAME%\Documents\GitHub\Vital\MAAB.RestApi\MAAB.RestApi.sln" /property:Configuration=Debug /t:rebuild
start "API" "C:\Users\%USERNAME%\Documents\GitHub\Vital\MAAB.RestApi\MAAB.RestApi\bin\Debug\MAAB.RestApi.exe"


echo ----------------------------[AGUARDANDO A API]-------------------------------

ping -n 10 127.0.0.1 > NUL

C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe "C:\Users\%USERNAME%\Documents\GitHub\Vital\MAAB.TestesAceitacao\CargaDeDadosAPI\CargaDeDadosAPI.csproj" /property:Configuration=Debug /t:rebuild

start "Carga" "C:\Users\%USERNAME%\Documents\GitHub\Vital\MAAB.TestesAceitacao\CargaDeDadosAPI\bin\Debug\CargaDeDadosAPI.exe"  %Convenio% -%GLOBAL%

chcp %cp%>nul