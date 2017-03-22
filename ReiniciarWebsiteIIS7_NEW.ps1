Param(
    [string]$NombreWebsite
    )

Import-module webadministration

write-host "Parametro recibido de SCOM: $NombreWebsite"
start-website $NombreWebsite
write-host $NombreWebsite "iniciado"


