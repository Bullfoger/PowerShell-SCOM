Import-Module OperationsManager
#$Fecha = Get-Date
#$UTC = $Fecha.ToUniversalTime()
#$Dif = $Fecha - $UTC
#$Conversion = [string]$Dif
#$Conversion = $Conversion.Replace(":00:00", "")
#[int]$TimeToAdd=$Conversion
#$AgeHours = $TimeToAdd#+48
$connect= New-SCOMManagementGroupConnection –ComputerName w12r-cz-vscom1.comercio.age
$alertBCKF=Get-SCOMAlert -Criteria 'ResolutionState=''0'' AND Name=''Database Backup Failed To Complete'''#|where {$_.TimeAdded -le (Get-Date).addhours(-$AgeHours)}
foreach ($alertBCKFs in $alertBCKF)
{
Set-SCOMAlert -Alert $alertBCKFs -ResolutionState 10 -Comment 'ALERTA MOVIDA MEDIANTE SCRIPT'
}
$alertBCKSO=Get-SCOMAlert -Criteria 'ResolutionState=''0'' AND Name=''Backup device failed - Operating system error'''#|where {$_.TimeAdded -le (Get-Date).addhours(-$AgeHours)} 
foreach ($alertBCKSOs in $alertBCKSO)
{
Set-SCOMAlert -Alert $alertBCKSOs -ResolutionState 10 -Comment 'ALERTA MOVIDA MEDIANTE SCRIPT'
}
$alertispkg=Get-SCOMAlert -Criteria 'ResolutionState=''0'' AND Name=''IS Package Failed'''#|where {$_.TimeAdded -le (Get-Date).addhours(-$AgeHours)} 
foreach ($alertispkgs in $alertispkg)
{
Set-SCOMAlert -Alert $alertispkgs -ResolutionState 10 -Comment 'ALERTA MOVIDA MEDIANTE SCRIPT'
}
$alertispkg1=Get-SCOMAlert -Criteria 'ResolutionState=''0'' AND Name=''MSSQL 2014: IS Package Failed'''#|where {$_.TimeAdded -le (Get-Date).addhours(-$AgeHours)} 
foreach ($alertispkg1s in $alertispkg1)
{
Set-SCOMAlert -Alert $alertispkg1s -ResolutionState 10 -Comment 'ALERTA MOVIDA MEDIANTE SCRIPT'
}
$alertilbk=Get-SCOMAlert -Criteria 'ResolutionState=''0'' AND Name=''Log Backup Failed to Complete'''#|where {$_.TimeAdded -le (Get-Date).addhours(-$AgeHours)} 
foreach ($alertilbks in $alertilbk)
{
Set-SCOMAlert -Alert $alertilbks -ResolutionState 10 -Comment 'ALERTA MOVIDA MEDIANTE SCRIPT'
}
$alert=Get-SCOMAlert -Criteria 'ResolutionState=''0'' AND Name=''Failed to open primary database file'''#|where {$_.TimeAdded -le (Get-Date).addhours(-$AgeHours)} 
foreach ($alerts in $alert)
{
Set-SCOMAlert -Alert $alerts -ResolutionState 10 -Comment 'ALERTA MOVIDA MEDIANTE SCRIPT'
}
