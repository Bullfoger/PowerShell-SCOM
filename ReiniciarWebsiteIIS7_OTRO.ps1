Param(
    [string]$NombreWebsite
    )

Import-module webadministration

#$NombreWebsite = "ee\sf\d\2"
$NumeroDelWebsite = $NombreWebsite.split("/")[1]

write-host $NombreWebsite
write-host $NumeroDelWebsite

foreach ($sitio in Get-Website){
    if ($sitio.Id -eq $NumeroDelWebsite ){
        Start-Website $Sitio.Name
        write-host $sitio.name "Iniciado"
    } 
}
