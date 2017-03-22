Import-Module OperationsManager
#$Fecha = Get-Date
#$UTC = $Fecha.ToUniversalTime()
#$Dif = $Fecha - $UTC
#$Conversion = [string]$Dif
#$Conversion = $Conversion.Replace(":00:00", "")
#[int]$TimeToAdd=$Conversion
#$AgeHours = $TimeToAdd#+48
$connect= New-SCOMManagementGroupConnection –ComputerName w12r-cz-vscom1.comercio.age
$alerttmg=Get-SCOMAlert -Criteria 'ResolutionState<>''255'' AND Name=''The number of TCP connections per minute from a specific source IP address exceeded the configured limit'''#|where {$_.TimeAdded -le (Get-Date).addhours(-$AgeHours)}
foreach ($alerttmgs in $alerttmg)
{
Set-SCOMAlert -Alert $alerttmgs -ResolutionState 255 -Comment 'ALERTA AUTO-CERRADA. ALERTA ENVIADA A COMUNICACIONES POR MAIL'
}
$alerttmg1=Get-SCOMAlert -Criteria 'ResolutionState<>''255'' AND Name=''The number of denied connections from a specific source IP address exceeded the configured limit'''#|where {$_.TimeAdded -le (Get-Date).addhours(-$AgeHours)} 
foreach ($alerttmg1s in $alerttmg1)
{
Set-SCOMAlert -Alert $alerttmg1s -ResolutionState 255 -Comment 'ALERTA AUTO-CERRADA. ALERTA ENVIADA A COMUNICACIONES POR MAIL'
}
$alerttmg2=Get-SCOMAlert -Criteria 'ResolutionState<>''255'' AND Name=''The number of TCP connections allowed from a specific source IP address exceeded the configured limit'''#|where {$_.TimeAdded -le (Get-Date).addhours(-$AgeHours)} 
foreach ($alerttmg2s in $alerttmg2)
{
Set-SCOMAlert -Alert $alerttmg2s -ResolutionState 255 -Comment 'ALERTA AUTO-CERRADA. ALERTA ENVIADA A COMUNICACIONES POR MAIL'
}
$alertPKG=Get-SCOMAlert -Criteria 'ResolutionState<>''255'' AND Name=''Operations Manager failed to start a process'''#|where {$_.TimeAdded -le (Get-Date).addhours(-$AgeHours)} 
foreach ($alertPKGs in $alertPKG)
{
Set-SCOMAlert -Alert $alertPKGs -ResolutionState 255 -Comment 'ALERTA AUTO-CERRADA MEDIANTE SCRIPT.'
}
$alertdns=Get-SCOMAlert -Criteria 'ResolutionState<>''255'' AND Name=''Windows DNS - Configuration - Zone Expiration'''#|where {$_.TimeAdded -le (Get-Date).addhours(-$AgeHours)} 
foreach ($alertdnss in $alertdns)
{
Set-SCOMAlert -Alert $alertdnss -ResolutionState 255 -Comment 'ALERTA AUTO-CERRADA MEDIANTE SCRIPT.'
}
$alerttmg3=Get-SCOMAlert -Criteria 'ResolutionState<>''255'' AND Name='' The number of TCP connections per minute from a specific source IP address exceeded the configured limit'''#|where {$_.TimeAdded -le (Get-Date).addhours(-$AgeHours)} 
foreach ($alerttmg3s in $alerttmg3)
{
Set-SCOMAlert -Alert $alerttmg3s -ResolutionState 255 -Comment 'ALERTA AUTO-CERRADA. ALERTA ENVIADA A COMUNICACIONES POR MAIL'
}
$alertMcaffe=Get-SCOMAlert -Criteria 'ResolutionState<> 255' | where {$_.CustomField1 -eq "Alarma generada por MacAffe"}
foreach ($alertMcaffes in $alertMcaffe)
{
Set-SCOMAlert -Alert $alertMcaffes -ResolutionState 255 -Comment 'ALERTA AUTO-CERRADA. ALARMA DOCUMENTADA SE PUEDE IGNORAR'
}
