New-PSDrive -Name NETCUZCOVEST -PSProvider FileSystem -Root \\comappsweb\netcuzcovest$ | Out-Null
$FicheroTest = 'NETCUZCOVEST:/TestScomNOBORRAR.txt'
$ficheroExiste = Test-Path $FicheroTest
If ($ficheroExiste -eq $true)
    {
     Write-EventLog ESTACICE -EventId 1  -EntryType Information -Source "ESTACICE" -Category  4 -Message "Se tiene ACCESO a \\comappsweb\netcuzcovest$ "
    }
    else
    {
    Write-EventLog ESTACICE -EventId 2 -EntryType Error -Source "ESTACICE" -Category  4 -Message "ERROR en APP ESTACICE NO SE ACCEDE A \\comappsweb\netcuzcovest$"
    }
Remove-PSDrive NETCUZCOVEST