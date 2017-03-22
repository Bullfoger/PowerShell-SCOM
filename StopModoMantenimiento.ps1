#Buscamos objetos que esten en modo mantenimiento y le cambiamos la fecha por la actual para que termine
Import-module OperationsManager

$Instance = Get-SCOMClassInstance 
$MMEntry = Get-SCOMMaintenanceMode -Instance $Instance
$NewEndTime = (Get-Date)
Set-SCOMMaintenanceMode -MaintenanceModeEntry $MMEntry -EndTime $NewEndTime -Comment "Mantenimiento completado"
