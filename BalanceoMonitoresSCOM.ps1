Import-Module '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\ScriptScom\Funciones\invoke-ping.ps1'
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
$test= Invoke-Ping -ComputerName w12r-vscom.comercio.age -Detail *
If ($test.Ping -eq "True")
    {
    New-PSDrive -Name LogBalanceo -PSProvider FileSystem -Root '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\LOG_BALANCEO_MONITORES'
    $log = Get-Item LogBalanceo:/BalanceoMonitores.log
    $pesofichero = (Get-ItemProperty -Path $log).Length
    if ($pesofichero -gt 102400)
    {Clear-Content LogBalanceo:/BalanceoMonitores.log }
##################
#Fin Acceso LOG
##################
    Write-Output "$(Get-TimeStamp) $($HostName) - HAY CONEXION CON $($Test.Name) EN LA SIGUIENTE IP $($Test.IP) " | Add-Content $log
##################
#Comprobar Task
##################
Write-Output "$(Get-TimeStamp) $($HostName) - COMPROBAMOS EL ESTADO DE LAS TASK " | Add-Content $log
$TareasOffName = Get-Content '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\ScriptScom\BALANCEOSCOM\TASK\TareasOFF.txt'
       foreach ($task in $TareasOffName)
            {
             $statetask=Get-ScheduledTask -TaskName $task
                  if ($statetask.state -eq "Disabled")
                         {
                         Write-Output "$(Get-TimeStamp) $($HostName) - La Tarea $($task) esta Disabled " | Add-Content $log
                         }
                         Else
                         {
                         Disable-ScheduledTask -TaskName $task
                         Write-Output "$(Get-TimeStamp) $($HostName) - La Tarea $($task) estaba Ready y se ha cambiado a Disabled " | Add-Content $log
                         }
             }
$taskBalanceo = Get-ScheduledTask -TaskName 'Balanceo Monitores SCOM'
	if ($taskBalanceo.State -eq "Ready")
		{
		Write-Output "$(Get-TimeStamp) $($HostName) - La Tarea $($taskBalanceo.Name) esta Ready " | Add-Content $log
		}
	Else
		{
		Enable-ScheduledTask -TaskName $taskBalanceo.Name
		}
Write-Output "$(Get-TimeStamp) $($HostName) - FIN DE DE LA COMPROBACION DE LAS TASK " | Add-Content $log
##################
#Fin Comprobar Task
##################
    Remove-PSDrive LogBalanceo
    }
Else
    {
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
    New-PSDrive -Name LogBalanceo -PSProvider FileSystem -Root '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\LOG_BALANCEO_MONITORES'
    $log = Get-Item LogBalanceo:/BalanceoMonitores.log
    $pesofichero = (Get-ItemProperty -Path $log).Length
        if ($pesofichero -gt 102400)
            {
			Clear-Content LogBalanceo:/BalanceoMonitores.log
			}
    ####################
    #Fin Acceso LOG
    ####################
    Write-Output "$(Get-TimeStamp) $($HostName) - NO HAY CONEXION CON $($HostName)" | Add-Content $log
    Import-Module OperationsManager
    ####################
    #Cargamos Monitores
    ###################
    $MonitorDisableAduanetXML = Get-Content '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\ScriptScom\BALANCEOSCOM\MonitoresADUANETXML\MonitorPrincipalADUANET.txt'
    $MonitorEnableAduanetXML = Get-Content '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\ScriptScom\BALANCEOSCOM\MonitoresADUANETXML\MonitorBCKADUANET.txt'
    $MonitorDisableShareEstacice = Get-Content '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\ScriptScom\BALANCEOSCOM\MonitoresSHAREESTACICE\MonitorPrincipalESTACICE.txt'
    $MonitorEnableShareEstacice = Get-Content '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\ScriptScom\BALANCEOSCOM\MonitoresSHAREESTACICE\MonitorBCKESTACICE.txt'
    $MonitorDisableADUANAS = Get-Content '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\ScriptScom\BALANCEOSCOM\MonitoresADUANAS\MonitorPrincipalADUANAS.txt'
    $MonitorEnableADUANAS = Get-Content '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\ScriptScom\BALANCEOSCOM\MonitoresADUANAS\MonitorBCKADUANAS.txt'
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
        Disable-SCOMMonitor -Class $classAduanetxml -ManagementPack $MPADUANETXML -Monitor $Monitor -Enforce
        Write-Output "$(Get-TimeStamp) $($HostName)- DESHABILITADO -$($Monitor.DisplayName)" | Add-Content $log
        }
    foreach ($MonitorID in $MonitorEnableAduanetXML)
        {
        $Monitor = Get-SCOMMonitor -id $MonitorID
        Enable-SCOMMonitor -Class $classAduanetxmlbck -ManagementPack $MPADUANETXML -Monitor $Monitor -Enforce
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
        Disable-SCOMMonitor -Class $classAduanas -ManagementPack $MPADUANAS -Monitor $Monitor -Enforce
        Write-Output "$(Get-TimeStamp) $($HostName) - DESHABILITADO - $($Monitor.DisplayName)" | Add-Content $log
        }
        foreach ($MonitorID in $MonitorEnableADUANAS)
        {
        $Monitor = Get-SCOMMonitor -id $MonitorID
        Enable-SCOMMonitor -Class $classAduanasBCK -ManagementPack $MPADUANAS -Monitor $Monitor -Enforce
        Write-Output "$(Get-TimeStamp) $($HostName) -HABILITADO - $($Monitor.DisplayName)" | Add-Content $log
        }
    ###################
	#ARRANCAMOS LAS Task
	###################
    Write-Output "$(Get-TimeStamp) $($HostName) - ARRANCAMOS LAS TASK " | Add-Content $log
    $TareasOffName = Get-Content '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\ScriptScom\BALANCEOSCOM\TASK\TareasOFF.txt'
    foreach ($task in $TareasOffName)
        {
        $statetask=Get-ScheduledTask -TaskName $task
            if ($statetask.state -eq "Disabled")
                {
                Enable-ScheduledTask -TaskName $task
				Write-Output "$(Get-TimeStamp) $($HostName) - La Tarea $($task) estaba Disabled y se ha cambiado a Ready " | Add-Content $log
				}
            Else
                {
                Write-Output "$(Get-TimeStamp) $($HostName) - La Tarea $($task) esta Ready" | Add-Content $log
                }
        }
	$taskBalanceo = Get-Get-ScheduledTask -TaskName 'Balanceo Monitores SCOM'
	if ($taskBalanceo.State -eq "Ready")
		{
		Disable-ScheduledTask -TaskName $taskBalanceo.Name
		}
	Else
		{
		Write-Output "$(Get-TimeStamp) $($HostName) - La Tarea $($taskBalanceo.Name) esta Disabled " | Add-Content $log
		}
    Write-Output "$(Get-TimeStamp) $($HostName) - FIN DE DE LA COMPROBACION DE LAS TASK " | Add-Content $log
    Remove-PSDrive LogBalanceo
    Write-Output "$(Get-TimeStamp) $($HostName) - HA TEMMINDADO EL BALANCEO" | Add-Content $log
    }