#
#Gestionamos Conexion al Cluster
$session= New-PSSession -ComputerName w12rczcls12
Invoke-Command -Session $session -ScriptBlock {
    #Funcion Firma de Tiempo para LOG
    function Get-TimeStamp {
        return "[{0:dd/MM/yyyy} {0:HH:mm:ss}]" -f (Get-Date)
    }
    #Usuario y clave para montar la unida de LOG
    $password = ConvertTo-SecureString "WagnerSEC" -AsPlainText -Force
    $cred= New-Object System.Management.Automation.PSCredential ("secyt\scomadmin", $password )
    #Montamos la UNIDAD de LOG
    New-PSDrive -Name LOG -PSProvider FileSystem -Root '\\nas-cuzco-cifs\sgainformat$\SISTEMAS\SCOM_NO_TOCAR\LOG_ADUANAS_COMUNICA' -Credential $cred;
    #Variable ubicacion LOG
    $log = Get-Item LOG:/LogReincioLanzaAplicaciones.log
    #Guardamos el estado de recurso
    $estadoRecurso = Get-ClusterResource -Name "Lanza Aplicaciones"
    $estado = $estadoRecurso.State
    $nombreRecurso = $estadoRecurso.Name
    #Condicional 
    If ($estado -eq "Online")
        {Write-Output "$(Get-TimeStamp) El Recurso $nombreRecurso es $estado. APAGAMOS EL RECURSO " | Add-Content $log;
         stop-ClusterResource -Name "Lanza Aplicaciones"
         $AduanasComunica=Get-Process -Name AduanasComunica -ErrorAction SilentlyContinue;
         $id1=$AduanasComunica.id
         if ($AduanasComunica -eq $null)
            {Write-Output "$(Get-TimeStamp) AduanasComunica no se esta ejecutando. NO HACEMOS NADA" | Add-Content $log;}
                else
                    {Write-Output "$(Get-TimeStamp) AduanasComunica se esta ejecutando con PID $id1 . PARAMOS EL PROCESO" | Add-Content $log;
                     Get-Process -Name AduanasComunica | Where StartTime -lt (Get-Date).AddMinutes(-10) | Stop-Process -Force}
        $AduanasComunicaEstacice=Get-Process -Name AduanasComunicaEstacice -ErrorAction SilentlyContinue;
        $id2=$AduanasComunicaEstacice.id
        if ($AduanasComunicaEstacice -eq $null)
            {Write-Output "$(Get-TimeStamp) AduanasComunicaEstacice no se esta ejecutando. NO HACEMOS NADA" | Add-Content $log;}
                 else
                    {Write-Output "$(Get-TimeStamp) AduanasComunicaEstacicese esta ejecutando con PID $id2. PARAMOS EL PROCESO " | Add-Content $log;
                    Get-Process -Name AduanasComunicaEstacice | Where StartTime -lt (Get-Date).AddMinutes(-10) | Stop-Process -Force}
        $AduanasComunicaDefen=Get-Process -Name AduanasComunicaDefen -ErrorAction SilentlyContinue
        $id3=$AduanasComunicaDefen.id
        if ($AduanasComunicaDefen -eq $null)
            {Write-Output "$(Get-TimeStamp) AduanasComunicaDefen no se esta ejecutando. NO HACEMOS NADA " | Add-Content $log;}
                else
                    {Write-Output "$(Get-TimeStamp) AduanasComunicaDefen esta ejecutando con PID $id3. PARAMOS EL PROCESO " | Add-Content $log;
                     Get-Process -Name AduanasComunicaDefen | Where StartTime -lt (Get-Date).AddMinutes(-10) | Stop-Process -Force}
            }
        else
            {Write-Output "$(Get-TimeStamp) El Recurso $nombreRecurso Esta $estado. Encendemos el recurso" | Add-Content $log;
             start-ClusterResource -Name "Lanza Aplicaciones";}
    #Esperamos 10 segundos
    start-sleep -s 10 ; 
    start-ClusterResource -Name "Lanza Aplicaciones";
    $NewestadoRecurso = Get-ClusterResource -Name "Lanza Aplicaciones"
    $NewEstado = $NewestadoRecurso.State
    Write-Output "$(Get-TimeStamp) El Recurso $nombreRecurso vuelve ha estar $estado" | Add-Content $log
    #Eliminamos Unidad LOG
    Remove-PSDrive -Name LOG;
}
#Cerramos Sesion REMOTA
Exit-PSSession
#Eliminamos Sesion Remota
Remove-PSSession -Session $session
