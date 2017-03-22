Invoke-Command -ComputerName w12rczcls12 -ScriptBlock {stop-ClusterResource -Name "Lanza Aplicaciones"; start-sleep -s 10 ; start-ClusterResource -Name "Lanza Aplicaciones" }
