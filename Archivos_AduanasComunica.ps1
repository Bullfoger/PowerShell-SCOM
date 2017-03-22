New-PSDrive -Name BandejaEntrada -PSProvider FileSystem -Root \\comappsweb\netcuzcovadu$\BandejaEntrada | Out-Null

$date = (Get-DAte).AddMinutes(-30)
$ListaFicheros = Get-childItem BandejaEntrada:/ | where-object {$_.LastWriteTime -le $date}
$NumFicheros = $ListaFicheros.count
write-host $NumFicheros

If ($NumFicheros -gt  10 ){
    write-host "Hay mas de 10"
    Write-EventLog Application -EventId 1 -Source AduanetXML -Category  4 -EntryType Error -Message "La aplicacion AduanasComunica tiene más de 10 ficheros en la bandeja de entrada con una antiguedad superior a 30 min."
    }elseif ($NumFicheros > 5 ){
    Write-EventLog Application -EventId 2 -Source AduanetXML -Category  2 -EntryType Warning -Message "La aplicacion AduanasComunica tiene más de 5 ficheros en la bandeja de entrada con una antiguedad superior a 30 min."
    }



Remove-PSDrive BandejaEntrada
