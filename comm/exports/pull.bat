copy ..\..\bin\flash\bin\GraveyardShift.swf /y

rd "Windows" /s /q
mkdir "Windows"

robocopy ..\..\bin\windows\cpp\bin Windows /MIR
pause