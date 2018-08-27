######
#Comprobamos el número de ficheros en Aduanas Comunica
##Ultima modificación 17/10/2017

New-PSDrive -Name BandejaEntrada -PSProvider FileSystem -Root \\comappsweb\netcuzcovadu$\BandejaEntrada | Out-Null

$date = (Get-Date).AddMinutes(-30)
$ListaFicheros = Get-childItem BandejaEntrada:/ | where-object {$_.CreationTime -le $date}
$NumFicheros = $ListaFicheros.count

If ($NumFicheros -gt  10 ){
    Write-EventLog AduanasComunica -EventId 2  -EntryType Error -Source "Bandeja de Entrada" -Category  4 -Message "La aplicacion AduanasComunica tiene más de 10 ficheros en la bandeja de entrada con una antiguedad superior a 30 min. Numero de Fichero $NumFicheros"
    }
    Else 
    {
    Write-EventLog AduanasComunica -EventId 1 -EntryType Information -Source "Bandeja de Entrada" -Category  4 -Message "La bandeja de Entrada tiene $NumFicheros Ficheros"
    }



Remove-PSDrive BandejaEntrada
