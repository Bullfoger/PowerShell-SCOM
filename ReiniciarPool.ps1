Param(
    [string]$NombrePool
    )

    

Import-Module WebAdministration

write-host "Parametro recibido de SCOM: $NombrePool"
Start-WebAppPool $nombrePool
