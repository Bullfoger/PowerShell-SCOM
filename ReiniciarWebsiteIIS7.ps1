﻿Param(
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


# SIG # Begin signature block
# MIIIdwYJKoZIhvcNAQcCoIIIaDCCCGQCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU7LA2g6iYpFDU3x3976wRM7HZ
# loKgggXhMIIF3TCCA8WgAwIBAgITJwAAY7/eNFAs3kfw/AAAAABjvzANBgkqhkiG
# 9w0BAQsFADBIMRMwEQYKCZImiZPyLGQBGRYDYWdlMRgwFgYKCZImiZPyLGQBGRYI
# Y29tZXJjaW8xFzAVBgNVBAMTDkNBIGRlIENvbWVyY2lvMB4XDTE2MDcyODExMzYw
# NloXDTE4MDcyODExNDYwNlowajEMMAoGA1UEChMDU0VDMREwDwYDVQQLEwhTSVNU
# RU1BUzEYMBYGA1UEAxMPRmlybWEgZGUgQ29kaWdvMS0wKwYJKoZIhvcNAQkBFh5h
# ZG1zaXN0ZW1hc0Bjb21lcmNpby5taW5lY28uZXMwggEiMA0GCSqGSIb3DQEBAQUA
# A4IBDwAwggEKAoIBAQC9CqUExkvD6TUkXz1l9WqMiPlIdbIe1Mn/+RAUkasOZkRQ
# ZtBxuk+O4Bg+UpOKT3olQdMLJdWWpavSp3lwtomEifz2NQNZXFFyJ3q72NYNC0+7
# 3D2jKuOF+maavSn1lX/MKr3dwqVXgp6nZAdKyhTzkIrNTaFqA3yZ0lDkem4mgT1s
# HUESvQ02VlGCGFlaWvyxq6grTUkNfjioctMeFTG6CIhktE5faIDIN5FybIlfxsm0
# +R4u5fn2AVntCW2h127JZxB6I9RT6WOYXQwNkOaAcLmJ4WszlJHHDozLzM5aruzj
# KVi3c6Er+kEEJuy6k02lHbOVTrwDWleVarCb/OGLAgMBAAGjggGcMIIBmDALBgNV
# HQ8EBAMCB4AwPAYJKwYBBAGCNxUHBC8wLQYlKwYBBAGCNxUI1O8ghK7JR4XNjz6G
# l7FIgqi7HV2Hsa4IhfS7RwIBZAIBBzAdBgNVHQ4EFgQUd1GAfv99VUiIvm1TIzs8
# d7qzLJUwHwYDVR0jBBgwFoAUcXRw6dPdvB8+O0wu/oXXBljp92owQwYDVR0fBDww
# OjA4oDagNIYyaHR0cDovL2NybC5jb21lcmNpby5lcy9jcmxzL0NBJTIwZGUlMjBD
# b21lcmNpby5jcmwwgZMGCCsGAQUFBwEBBIGGMIGDMFgGCCsGAQUFBzAChkxodHRw
# Oi8vY3JsLmNvbWVyY2lvLmVzL2NybHMvVzEyUi1DWi1WQ0ExLmNvbWVyY2lvLmFn
# ZV9DQSUyMGRlJTIwQ29tZXJjaW8uY3J0MCcGCCsGAQUFBzABhhtodHRwOi8vY3Js
# LmNvbWVyY2lvLmVzL29jc3AwEwYDVR0lBAwwCgYIKwYBBQUHAwMwGwYJKwYBBAGC
# NxUKBA4wDDAKBggrBgEFBQcDAzANBgkqhkiG9w0BAQsFAAOCAgEAHudTv+mIZsAn
# eF1qGhRr+jjdLKPy2uDBd52TwjpdETeltFmYvDiiTrQ6/YyvgMYY9aj0E7wvU0u6
# K628dv8D6ofOo/Y639EYh4N5zd+hUKvGT7cjPe4J/wumSweOhCuu66h9LIh9m98m
# 8QtxnDHjm4qb9V56TbaZLb5oIbZdi0TeJzTIZUJWNJ9+jJMUm0smflQhpqwiySOd
# Rl7mRmV1o/8YqzbMwZ3Xx9Ay5ywxQMdDp4MhtcLc7t3qOPGyXJwlZkHOZ8jUIFSu
# DuxTEYytHvjq0UkwQ8apARQOpjIHSiWBzvCAJdzqxU5p2BLxwAP38zM88XY3DjHt
# 0HUA9NE4eLYRfaHCx/ihdX3IKlGJ+79On/oSNbZhWYPdyJ16fSpmN+WFw0eIVLVz
# a04BFjFNSSpEdhORi/KA5a7T0PnIYg/L1+kqgTljRKBEw9TmlBU8TJswMDIgb2DQ
# fFtC+MpBdOc+pvkh31CwBnWfjn/98ZA1ET4yaECaMeBIaEbhDIo2vpKPSEXARi8M
# z+m9pkrvXP5kw2V09Vquz3zUJ6zhLfUv3sJwOrQw7jZuzAU5CqPTgPztpQsGRuvO
# zX+nv46dp/Cx6VFB/YGNFBd3BkUYA6kuTsACRV5PsXGjunvAurCsAC7xy8OMVDfS
# sLGXU5rJV1LEi6LfEg7aFVywzu8avg8xggIAMIIB/AIBATBfMEgxEzARBgoJkiaJ
# k/IsZAEZFgNhZ2UxGDAWBgoJkiaJk/IsZAEZFghjb21lcmNpbzEXMBUGA1UEAxMO
# Q0EgZGUgQ29tZXJjaW8CEycAAGO/3jRQLN5H8PwAAAAAY78wCQYFKw4DAhoFAKB4
# MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQB
# gjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkE
# MRYEFBmS7Y5Db4yklxw+0punFbO4VtJRMA0GCSqGSIb3DQEBAQUABIIBAE88j7FE
# FzI34uPWKPKyHuF3XVj4Qjl+jaDVgaGo5MV4fOZkCBdLDsliPfTpHnaEzwUCVZmo
# VvvxvDv0SLJjdHv4CnZ1k5EVM7K1gvgiY3pUJ2OiF+J3NgCgc0C7GK4H0YrOD35+
# 1lokgPYMEYffGxSR5KhecvhRFaCJ9aXruFnm61QcgYlrqScU63Z1xbVuj4hoYGAa
# ITrOrju9LwUNQ1D+NsdNLANsN3Rbx3M6C+VXGToe65SjXP8BpS/eQPKI67kZDlKc
# lUY5QrUbpNv3pDyfEv9LLmkQ9r2GgQztVXTQf2KSrFNiDNjlni0zjvTN55vsLxMY
# mD9IhRfWc3ecWAY=
# SIG # End signature block
