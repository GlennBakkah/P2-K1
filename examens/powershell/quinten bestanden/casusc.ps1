#Project naam : Actieve services controleren of deze op de zwarte lijst staan
#Casus : C
#Maker : Quinten
#Datum : 30-11-2023

$path = "$PSScriptroot.\blacklist.json" #relatief pad
$rapport = @{}
function PS-Version-Checker {
        
    if ($PSVersionTable.PSVersion.Major -ne 7) {
        Write-Host "Incorrect version detected" -ForegroundColor Red
        Write-Host "You are using an incorect version of powershell"
        Write-Host "Version required: 7"
        Write-Host "Current version:" $PSVersionTable.PSVersion.Major
    }
    else {
        Write-Host "Correct version detected"
    }
}

function Pad-Controle {
    Write-Host "Pad controle wordt uitgevoerd..." -ForegroundColor Blue
    Start-sleep 1
    if (Test-Path $path) {
        Write-Host "Pad bestaat" -ForegroundColor Green
    }
    else {
        Write-Host "Pad bestaat niet" -ForegroundColor Red
        Write-Host "Het script wordt afgelosten..." -ForegroundColor Red
        exit
    }
}

function Service-Check {
    $data = Get-Content -Path $path

    $json = $data | ConvertFrom-Json
    
    foreach ($item in $json.services) {
        $service = Get-Service -DisplayName $item.Displayname
        if ($service.status -eq "Running") {
            Write-Host "Actieve blacklist service gevonden!" -ForegroundColor Blue
            Start-Sleep 1
            if ($item.threat -eq "High") { 
                Write-Host $service.Displayname "is een hoog risico en word uitgeschakeld en gerapporteerd..." -ForegroundColor Red
                $rapport.add($service.displayname, "Hoog Risico")
                Start-Sleep 1
                Stop-Service $service
                Write-Host "Service is uitgeschakeld" -ForegroundColor Blue
            }
            elseif ($item.threat -eq "Medium") {
                Write-Host $service.Displayname "is een middelmatig risico en word gerapporteerd..." -ForegroundColor DarkRed
                Start-Sleep 1
                $rapport.add($service.displayname, "Middelmatig Risico")
            }
            elseif ($item.threat -eq "Low") {
                Write-Host $service.Displayname "is een laag risico, er word geen actie ondernomen..." -ForegroundColor Yellow
            }
            else { Write-Host "Er zijn geen risico's gevonden" }
        }
    }
}

function Rapport {
    Write-Host "Service Check is afgerond" -ForegroundColor Green
    if ($rapport.Count -eq 0) {
        Write-Host "Er zijn geen gerapporteerde items gevonden."
    }
    else {
        Write-Host "Hieronder vind u het rapport"
        $rapport
        Write-Host "Alle items met een hoog risico zijn uitgeschakeld" -ForegroundColor Blue
    }
}

Write-Host "-----------------Service Blacklist Check---------------------" -ForegroundColor Yellow
Write-Host "Dit script controleerd actieve services of deze op de blacklist staan en zet deze uit als dat het geval is" -ForegroundColor Yellow
while ($true) {
    $start = Read-Host "Wilt u het script uitvoeren? (Y/N)"

    if ($start -eq "Y") {
        Write-Host "Script word gestart..." -ForegroundColor Yellow
        Start-Sleep 3
        Break
    }
    elseif ($start -eq "N") {
        Write-Host "Script word afgesloten..."
        Start-Sleep 3
        Exit
    }
    else {
        Write-Host "Voer een geldig antwoord in!"
    }
}

while ($true) {
    $startversiecheck = Read-Host "Wilt u de powershell versie check uitvoeren? (Y/N)"

    if ($startversiecheck -eq "Y") {
        Write-Host "Versie check word uitgevoerd..."
        Start-Sleep 3
        PS-Version-Checker
        Break
    }
    elseif ($startversiecheck -eq "N") {
        Write-Host "Script gaat door zonder versie check..."
        Start-Sleep 1
        Break
    }
    else {
        Write-Host "Voer een geldig antwoord in!"
    }
}
Pad-Controle
Service-Check
Rapport
# SIG # Begin signature block
# MIIFdwYJKoZIhvcNAQcCoIIFaDCCBWQCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUbcrVSe1V3Wq93yp37T9nGD+5
# 9UKgggMaMIIDFjCCAf6gAwIBAgIQXX7VY8B+JZxELW8hcUGMbDANBgkqhkiG9w0B
# AQUFADASMRAwDgYDVQQDDAdRdWludGVuMB4XDTI0MDExMTExMDQyNFoXDTI1MDEx
# MTExMjQyNFowEjEQMA4GA1UEAwwHUXVpbnRlbjCCASIwDQYJKoZIhvcNAQEBBQAD
# ggEPADCCAQoCggEBAKpR3dhvjF9XEUUcin3hTDzukwhjwMPRtHy2YhcNEVmx/LQF
# 3k1shvwXVSoc44YjFKI5ZjMO+xQRDJRfhlYT2qSe7bUTHB6XTnoUGDomwp9JMj1H
# bJETiEHOOXqKJMuQiS6nm4cjhjWCVE53ZIKZoiwejuU6tSrobaLwhpI47DSFnBvM
# /Q81jO32oSAPd9e+PNqUCjV30sP56u7XwaAMBapXgjtPUVpeHogbgU0u2vGydweA
# H0dMhNtu1vti0G6gIc6JBhyoAhbbjc+MN1nwTn8PV5l1t0wRD3cvevkD3sY12T37
# dhcFgc1sAfkRlwUrGiyQlEUSfE5LCCOI/46bEN0CAwEAAaNoMGYwDgYDVR0PAQH/
# BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUFBwMDMCAGA1UdEQQZMBeCFXd3dy5ob3Jp
# em9uY29sbGVnZS5ubDAdBgNVHQ4EFgQUReETjoguHS1AET841kHj/0eM+FIwDQYJ
# KoZIhvcNAQEFBQADggEBABfnv1gwpfbvsqC5ZzgL2O7eRYbvNGb9wUIiKyP5JCIR
# kM2b5X19WsNpEmnqJc5tvDnf8AmSZVFz8UCT9xiKiMzvadTWedoxHRSJFssh332w
# 4I1Ok/44DFRcBNeXvvcejYdfM2HWAIYg/NH0hJGxfajq4Znbkh0zwZxhJRwf4qri
# rAoKn659RjuSVBGS9fU4b5PAVVIRcKBrXPq8uxzrFsakt55d9EwK7/xq+9xQOP1c
# XoJElNwRocl4gWh/MPNGdfrjAOpZKTCuDwJTNZ2W5e5/XrLC17GWqMDOIEceHRLr
# lPxKxTeaqPgjCp2GB93bpNfhCGazJ6r9byC5qQ1XgsExggHHMIIBwwIBATAmMBIx
# EDAOBgNVBAMMB1F1aW50ZW4CEF1+1WPAfiWcRC1vIXFBjGwwCQYFKw4DAhoFAKB4
# MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQB
# gjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkE
# MRYEFGqjKHPA/jQ4+Unh47hB1bpVE1RZMA0GCSqGSIb3DQEBAQUABIIBAD881+ju
# 14MuIxZQqDeEy2lEjUsINPzehILQzKAG+1WlTMD8SMMbRYn44+Ed6tzsmupHhqgb
# FFaMkXHRUdOhqAKjeoMJN/kwU8LvThiup/CjCyNqaONbo/qgcLE3KRJIQYMcAb4s
# Z3+bthaNBOV7j3LJNCCPnt99Py59LubAjvN0GUB1FVIrtQwHA3WDWbwIvOrPdZpL
# YUqWf4LGS/wEBg1zlg8jmuDHDrBQ1hg/Lu+gu+3Xsu8p2qWWU0pPAnaGE9RWE9yA
# FYJvyoXZDO3LUq36IKFOXFKel+EhJjxqk5vosPXWNhRMTg9Z8XDidysr7Ybw/85i
# XWkHQgVSVz5YMXg=
# SIG # End signature block
