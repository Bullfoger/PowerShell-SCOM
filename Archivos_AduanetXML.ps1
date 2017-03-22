New-PSDrive -Name BandejaSalida -PSProvider FileSystem -Root \\comappsweb\netcuzcovadu$\BandejaSalida | Out-Null

$date = (Get-DAte).AddMinutes(-30)
$ListaFicheros = Get-childItem BandejaSalida:/ | where-object {$_.LastWriteTime -le $date}
$NumFicheros = $ListaFicheros.count

If ($NumFicheros -gt 10 ){
    Write-EventLog Application -EventId 1 -Source AduanasComunica -Category  4 -EntryType Error -Message "La aplicacion Aduanas Comunica tiene más de 10 ficheros en la bandeja de salida con una antiguedad superior a 30 min."
    }



Remove-PSDrive BandejaSalida
