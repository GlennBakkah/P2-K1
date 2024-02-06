function PS-Version-Checker {
        
    if ($PSVersionTable.PSVersion.Major -ne 7) {
        Write-Host "Incorrect version detected" -ForegroundColor Red
        Write-Host "You are using an incorect version of powershell"
        Write-Host "Version required: 7"
        Write-Host "Current version" $PSVersionTable.PSVersion.Major
    }
    else {
        Write-Host "Correct version detected" -ForegroundColor Green
        Write-Host "Programma gaat verder." -ForegroundColor Green
    }
}

function Service-Check {
    $services = Get-Service -ErrorAction SilentlyContinue
    ForEach ($service in $services) {
        if ($service.Status -eq "Stopped") {
            Write-Host $service.Name -ForegroundColor Red
        }
    }
}

function RAM {
    $RAM = Get-Process | Where-Object WorkingSet -gt 1000000000
    if ($RAM -eq $null) {
        Write-Host "Er zijn geen processen boven de 1GB gevonden"
    }
    else {
        $RAM
    }
}

function Datum-Tijd {
    $DT = Get-Date
    Write-Host $DT -ForegroundColor Blue 
}

function OSspecs {
    $osspecs = Get-ComputerInfo
    Write-Host "Besturingsysteem:" -ForegroundColor Yellow $osspecs.OsName
    Write-Host "Besturingssysteem versie"  -ForegroundColor Yellow $osspecs.OsVersion
    Write-Host "Hoofdeigenaar:"  -ForegroundColor Yellow $osspecs.CsPrimaryOwnerName
    Write-Host "Windows installatie datum:" -ForegroundColor Yellow $osspecs.WindowsInstallDateFromRegistry
}

Write-Host "=======================Powershell Programma==========================="
Write-Host "1) Laat alle services zien die gestopt zijn"
Write-Host "2) Laat processen zien die 1gb of meer RAM gebruiken"
Write-Host "3) Laat datum en tijd zien"
Write-Host "4) Laat besturingssysteem informatie zien"
Write-Host "5) Sluit het programma af"
$antwoord = Read-Host "Maak uw keuze (1 t/m 5)"

if ($antwoord -match "[1-5]") {
    $versiecheck = Read-Host "Wilt u een powershell versie check uitvoeren?(Y/N)"
    if ($versiecheck -eq "Y") {
        PS-Version-Checker
    }
    elseif ($versiecheck -eq "N") {
        Write-Host "Check word niet uitgevoerd." -ForegroundColor DarkYellow
    }
    else {
        Write-Host "Voer een geldig antwoord in (Y/N)"
    }
    if ($antwoord -eq 1) {
        Service-Check
    }
    elseif ($antwoord -eq 2) {
        RAM
    }
    elseif ($antwoord -eq 3) {
        Datum-Tijd
    }
    elseif ($antwoord -eq 4) {
        OSspecs
    }
    elseif ($antwoord -eq 5) {
        Write-Host "Programma word gesloten..."
        Exit
    }
}
else {
    Write-Host "Voer een geldige keuze in"
}

