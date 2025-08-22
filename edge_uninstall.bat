@echo off

net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

taskkill /f /im msedge.exe
taskkill /f /im MicrosoftEdgeUpdate.exe
taskkill /f /im Widgets.exe

rmdir /s /q "C:\Program Files (x86)\Microsoft\Edge"
rmdir /s /q "%USERPROFILE%/AppData\Local\Microsoft\Edge"

del /s /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"

for /f "tokens=1,*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" ^| find "MicrosoftEdgeAutoLaunch_"') do reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v %%i /f
