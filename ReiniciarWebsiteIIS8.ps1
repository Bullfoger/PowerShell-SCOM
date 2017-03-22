Param(
    [string]$NombreWebsite
    )

$NumeroDelWebsite = $NombreWebsite.split("/")[1]
write-host "Parametro recibido de SCOM: $NombreWebsite"
write-host "Numero extraido: $numeroDelWebsite "


foreach ($sitio in Get-Website){
    if ($sitio.Id -eq $NumeroDelWebsite ){
        Start-Website $Sitio.Name
        write-host $sitio.name "Iniciado"
    } 
}
