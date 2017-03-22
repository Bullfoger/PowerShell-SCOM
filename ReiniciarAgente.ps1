Net Stop “HealthService”
Taskkill /f /t /im Healthservice.exe
Start-Sleep 3
Taskkill /f /t /im cscript.exe
Start-Sleep 3
get-childitem -recurse -Path “C:\Program Files\Microsoft Monitoring Agent\Agent\Health Service State” | remove-item -force -recurse
Start-Sleep 5
Net Start “HealthService”