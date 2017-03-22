Import-module OperationsManager


$Sigede = Get-SCOMClassInstance "Aplicacion SIGEDE"
$Cites = Get-SCOMClassInstance "Aplicacion CITES"
$Licencias = Get-SCOMClassInstance "Aplicacion Licencias"
$Rae = Get-SCOMClassInstance "Aplicacion RAE"
$EstaciceSQL = Get-SCOMClassInstance "Estacice SQL"
$Firma = Get-SCOMClassInstance "@Firma"

$Time=((Get-date).AddMinutes(30))


Start-SCOMMaintenanceMode -Instance $Sigede -EndTime $Time -Comment "Modo mantenimiento por la caida de @Firma"
Start-SCOMMaintenanceMode -Instance $Cites -EndTime $Time -Comment "Modo mantenimiento por la caida de @Firma"
Start-SCOMMaintenanceMode -Instance $Licencias -EndTime $Time -Comment "Modo mantenimiento por la caida de @Firma"
Start-SCOMMaintenanceMode -Instance $Rae -EndTime $Time -Comment "Modo mantenimiento por la caida de @Firma"
Start-SCOMMaintenanceMode -Instance $EstaciceSQL -EndTime $Time -Comment "Modo mantenimiento por la caida de @Firma"
Start-SCOMMaintenanceMode -Instance $Firma -EndTime $Time -Comment "Modo mantenimiento por la caida de @Firma"
