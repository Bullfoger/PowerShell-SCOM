Import-Module OperationsManager
#####################
#Funcion FECHA PARA LOG
#####################
function Get-TimeStamp 
{
return "[{0:dd/MM/yyyy} {0:HH:mm:ss}]" -f (Get-Date)
}
####################
#Acceso LOG
####################
$HostName = Hostname
New-PSDrive -Name LogBalanceo -PSProvider FileSystem -Root '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\LOG_BALANCEO_MONITORES'
$log = Get-Item LogBalanceo:/BalanceoMonitores.log
$pesofichero = (Get-ItemProperty -Path $log).Length
if ($pesofichero -gt 102400)
{Clear-Content LogBalanceo:/BalanceoMonitores.log }
 
Write-Output "$(Get-TimeStamp) $($HostName) - EL SERVIDOR ACABA DE ARRANCAR" | Add-Content $log
####################
#Cargamos Monitores
###################        
$MonitorDisableAduanetXML = Get-Content '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\ScriptScom\BALANCEOSCOM\MonitoresADUANETXML\MonitorBCKADUANET.txt'
$MonitorEnableAduanetXML = Get-Content '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\ScriptScom\BALANCEOSCOM\MonitoresADUANETXML\MonitorPrincipalADUANET.txt'
$MonitorDisableShareEstacice = Get-Content '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\ScriptScom\BALANCEOSCOM\MonitoresSHAREESTACICE\MonitorBCKESTACICE.txt'
$MonitorEnableShareEstacice = Get-Content '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\ScriptScom\BALANCEOSCOM\MonitoresSHAREESTACICE\MonitorPrincipalESTACICE.txt'
$MonitorDisableADUANAS = Get-Content '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\ScriptScom\BALANCEOSCOM\MonitoresADUANAS\MonitorBCKADUANAS.txt'
$MonitorEnableADUANAS = Get-Content '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\ScriptScom\BALANCEOSCOM\MonitoresADUANAS\MonitorPrincipalADUANAS.txt'
####################
#Cargamos MP
####################
$MPADUANETXML = Get-SCOMManagementPack -Id 844a5dbc-184e-52eb-412b-9859aadc0a43 #MP ADUANETXML
$MPESTACICE = Get-SCOMManagementPack -Id e942e01b-cca2-6f0a-e28f-c26116074779
$MPADUANAS = Get-SCOMManagementPack -Id d9f11e0f-fe59-999c-b216-408aeeaca632
####################
#Cargamos las Clases
####################
$classAduanetxml = Get-SCOMClass -id ed5c1191-9e49-2ebc-71f6-044d89c8b2ef
$classAduanetxmlbck = Get-SCOMClass -id 362777bc-f2f3-8567-8d9b-13ed3b8fcf41
$classShareEstacice = Get-SCOMClass -id 8f0ac131-c315-3fbd-fe63-98bea6e12eaf
$classShareEstaciceBCK = Get-SCOMClass -id f824c015-0567-fbbb-65c2-1068411996e1
$classAduanas = Get-SCOMClass -id b18cdcca-7e09-f318-635c-7b6159d220bd
$classAduanasBCK = Get-SCOMClass -id edec401e-73e2-13b2-aa1a-8d62521f64c4
###################
#Apagamos y encendemos monitores
###################
foreach ($MonitorID in $MonitorDisableAduanetXML)
         {
         $Monitor = Get-SCOMMonitor -id $MonitorID
         Disable-SCOMMonitor -Class $classAduanetXMLbck -ManagementPack $MPADUANETXML -Monitor $Monitor -Enforce
         Write-Output "$(Get-TimeStamp) $($HostName) - DESHABILITADO - $($Monitor.DisplayName)" | Add-Content $log
         }
foreach ($MonitorID in $MonitorEnableAduanetXML)
         {
         $Monitor = Get-SCOMMonitor -id $MonitorID
         Enable-SCOMMonitor -Class $classAduanetXML -ManagementPack $MPADUANETXML -Monitor $Monitor -Enforce
         Write-Output "$(Get-TimeStamp) $($HostName) -HABILITADO - $($Monitor.DisplayName)" | Add-Content $log
         }
foreach ($MonitorID in $MonitorDisableShareEstacice)
         {
         $Monitor = Get-SCOMMonitor -id $MonitorID
         Disable-SCOMMonitor -Class $classShareEstaciceBCK -ManagementPack $MPESTACICE -Monitor $Monitor -Enforce
         Write-Output "$(Get-TimeStamp) $($HostName) - DESHABILITADO - $($Monitor.DisplayName)" | Add-Content $log
         }
foreach ($MonitorID in $MonitorEnableShareEstacice)
         {
         $Monitor = Get-SCOMMonitor -id $MonitorID
         Enable-SCOMMonitor -Class $classShareEstacice -ManagementPack $MPESTACICE -Monitor $Monitor -Enforce
         Write-Output "$(Get-TimeStamp) $($HostName) -HABILITADO - $($Monitor.DisplayName)" | Add-Content $log
         }
foreach ($MonitorID in $MonitorDisableADUANAS)
         {
         $Monitor = Get-SCOMMonitor -id $MonitorID
         Disable-SCOMMonitor -Class $classAduanasBCK -ManagementPack $MPADUANAS -Monitor $Monitor -Enforce
         Write-Output "$(Get-TimeStamp) $($HostName) - DESHABILITADO - $($Monitor.DisplayName)" | Add-Content $log
         }
foreach ($MonitorID in $MonitorEnableShareADUANAS)
         {
         $Monitor = Get-SCOMMonitor -id $MonitorID
         Enable-SCOMMonitor -Class $classAduanas -ManagementPack $MPADUANAS -Monitor $Monitor -Enforce
         Write-Output "$(Get-TimeStamp) $($HostName) -HABILITADO - $($Monitor.DisplayName)" | Add-Content $log
         }
Remove-PSDrive LogBalanceo