#####################
#Funcion FECHA PARA LOG
#####################
function Get-TimeStamp {
    
    return "[{0:dd/MM/yyyy} {0:HH:mm:ss}]" -f (Get-Date)
    
}

Try
{
    New-PSDrive -Name BandejaSalida -PSProvider FileSystem -Root \\comappsweb\netcuzcovadu$\BandejaSalida -ErrorAction Stop
    $test=Test-Path BandejaSalida:/
    if($test -eq 'True')
        { Write-EventLog AccesoShareADUANETXML -EventId 1 -Source ADUANETXML -Category 4 -EntryType Information -Message "Accedemos a la Bandeja de Salida" }
}
Catch 
{
$MensajeError = $_.Exception.Message
$NombreObjeto = $_.Exception.ItemName
Write-EventLog AccesoShareADUANETXML -EventId 2 -Source ADUANETXML -Category 4 -EntryType Error -Message "ERROR EN EL SCRIPT ADUANETXML al montar el Drive $NombreObjeto  $MensajeError."
}

#Contamos Ficheros
$date = (Get-DAte).AddMinutes(-30)
Try
{
$ContarFicheros= Get-childItem BandejaSalida:/ -file -ErrorAction Stop
$NumFicheros = $ContarFicheros.count
Write-EventLog FicheroSinFiltroADUANETXML -EventId 1 -Source FicheroSinFiltroADUANETXML -Category 4 -EntryType Information -Message "Hay $NumFicheros ficheros en la Bandeja de Salida."
$ListaFicheros = Get-childItem BandejaSalida:/ -file | where-object {$_.CreationTime -le $date} -ErrorAction Stop
$NumFicherosConfiltro = $ListaFicheros.count 
}
Catch 
{
$MensajeError = $_.Exception.Message
$NombreObjeto = $_.Exception.ItemName
Write-EventLog FicheroSinFiltroADUANETXML -EventId 2 -Source FicheroSinFiltroADUANETXML -Category 4 -EntryType Error -Message "ERROR EN EL SCRIPT ADUANETXML AL contar los ficheros $NombreObjeto  $MensajeError."
Write-EventLog BandejaDeSalidaADUANETXML -EventId 2 -Source BandejaDeSalidaADUANETXML -Category 4 -EntryType Error -Message "ERROR EN EL SCRIPT ADUANETXML AL contar los ficheros $NombreObjeto  $MensajeError."
}

If ($NumFicherosConfiltro -gt 10 ){
    Write-EventLog BandejaDeSalidaADUANETXML -EventId 2 -Source BandejaDeSalidaADUANETXML -Category 4 -EntryType Error -Message "Hay $NumFicherosConfiltro ficheros en la Bandeja de Salida. La aplicación AduanetXML tiene más de 10 ficheros con una antigüedad superior a 30 min."
    }
    else
    {Write-EventLog BandejaDeSalidaADUANETXML -EventId 1 -Source BandejaDeSalidaADUANETXML -Category 4 -EntryType Information -Message "Hay $NumFicherosConfiltro ficheros en la Bandeja de Salida."
    }
#Comprobamos la ultima modificacion del fichero log
$File = "\\comappsweb\netcuzcovadu$\Logs\aduanetxml2.log.0"
$lastwritetime = (Get-Item $File).LastWriteTime
if ($lastwritetime -le $date){
     Write-EventLog LogTimeLastWriteADUANETXML -EventId 2 -Source LogTimeLastWriteADUANETXML -Category 4 -EntryType Error -Message "ERROR El fichero de Log aduanetxml2.log.0 lleva mas de 30 minutos sin actualizarse - '$lastwritetime' - Se reinicia el recurso ADUANETXML"
     }
     else 
     {
     Write-EventLog LogTimeLastWriteADUANETXML -EventId 1 -Source LogTimeLastWriteADUANETXML -Category 4 -EntryType Information -Message "El fichero de Log aduanetxml2.log.0 Tiene la siguiente fecha - '$lastwritetime' -"
     }


Remove-PSDrive BandejaSalida