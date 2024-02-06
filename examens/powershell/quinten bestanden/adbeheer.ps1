$path = "C:\Users\Quint\OneDrive\Bureaublad\School\Powershell\ADBeheer\Employees.csv"
function Start-Begin() {
    # Deze functie zorgt voor het begin van het script.
    # In de functie word de titel benoemd, meerdere if statements om akkoord 
    # te gaan voor het uitvoeren en een waarschuwing voordat het script begint.
    while ($true) {
        Write-Host "-----------------AD BEHEER----------------"
        Write-Host "Welkom bij het AD Beheer"
        $start = Read-Host "Wilt u het script uitvoeren? (Y/N)"

        if ($start -eq "Y") {
            Write-Host "Let op! Dit script importeert gebruikers!" -ForegroundColor DarkYellow
            $def = Read-Host "Weet u zeker dat u het wilt uitvoeren? (Y/N)" 

            if ($def -eq "Y") {
                Write-Host "Script word uitgevoerd." -ForegroundColor Green
                Break
        
            }
            elseif ($def -eq "N") {
                Write-Host "Script word afgesloten..." -ForegroundColor Red
                Start-Sleep 3
                exit 
            }
            else {
                Write-Host "Voer een geldige waarde in." -ForegroundColor Red
                Write-Host "Het script herstart..."
                Start-Sleep 3
            }
        }
        elseif ($start -eq "N") {
            Write-Host "Script word afgesloten..." -ForegroundColor Red
            Start-Sleep 3
            exit 
        }
        else {
            Write-Host "Voer een geldige waarde in." -ForegroundColor Red
            Write-Host "Het script herstart..."
            Start-Sleep 3
        }
    }
}

function Check-Path-Functie() {
    # In deze functie word de locatie van het CSV bestand gechecked.
    $filecheck = Test-Path -Path $path

    if ($filecheck) {
        Write-Host "File Exists" -ForegroundColor Green
    }
    else {
        Write-Host "File Doesn't Exist" -ForegroundColor Red
        Start-Sleep 5
        exit
    }
}

function New-User() {
    # In deze functie wordt het CSV bestand omgezet in lossen properties
    # om vervolgens toe te voegen aan de Active Directory.

    $employees = Import-Csv -Path $path -Delimiter ";"

    foreach ($employee in $employees) {
        $Fullname = $employee.'Full Name'
        $Jobtitle = $employee.'Job Title'
        $Department = $employee.'Department'
        $Country = $employee.'Country'
        $City = $employee.'City'
        $Password = ConvertTo-SecureString -AsPlainText "password" -Force
    
        New-ADUser -Name $Fullname -Title $Jobtitle -Department $Department -Country $Country -City $City -AccountPassword $Password
    }
}

Start-Begin

Check-Path-Functie

New-User
