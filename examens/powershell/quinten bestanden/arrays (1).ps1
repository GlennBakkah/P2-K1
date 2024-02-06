$takenlijst = @{"Huiswerk" = "[ ]"; "Gamen" = "[ ]" }


Write-Host "=============Takenlijst================"
$takenlijst
Write-Host "#1 Taak toevoegen"
Write-Host "#2 Taak verwijderen"
Write-Host "#3 Taak aanpassen"
Write-Host "#4 Taak afvinken"
Write-Host "#5 Afvinken verwijderen"
Write-Host "#6 Programma afsluiten"

while ($true) {
    $Optie = Read-Host "Kies een optie (1 t/m 6)"

    if ($Optie -eq 1) {
        $Taaknaam = Read-Host "Wat is de naam van uw taak?"
        $takenlijst.Add("$Taaknaam", "[ ]")
    }
    elseif ($Optie -eq 2) {
        $Verwijderen = Read-Host "Welke taak wilt u verwijderen?"
        $takenlijst.Remove("$Verwijderen")
    }
    elseif ($Optie -eq 3) {
        $Aanpassen = Read-Host "Welke taak wilt u aanpassen?"
        $Nieuw = Read-Host "Hoe wilt u de taak noemen?"
        $takenlijst.Remove("$Aanpassen")
        $takenlijst.Add("$Nieuw", "[ ]")       
    }
    elseif ($Optie -eq 4) {
        $klaar = Read-Host "Welke taak wilt u afvinken?"
        $takenlijst.set_item("$klaar", "[X]")
    }
    elseif ($Optie -eq 5) {
        $nietafvinken = Read-Host "Welk vinkje wilt u verwijderen?"
        $takenlijst.set_item("$nietafvinken", "[ ]")
    }
    elseif ($Optie -eq 6) {
        Write-Host "Tot ziens"
        exit
    }
    elseif ($Optie -ne (1, 2, 3, 4, 5 , 6) ) {
        Write-Host "Ongeldige optie"
        while ($true) {
            $Opnieuw = Read-Host "Wilt u het opnieuw proberen? (Y/N)"
      
            if ($Opnieuw -eq "Y") {
                Write-Host "Het programma start opnieuw in 5 seconden."
                Start-Sleep 5
                Break
            }
            elseif ($Opnieuw -eq "N") {
                Write-Host "Het programma word afgesloten..."
                Start-Sleep 3
                Exit
            }
            else {
                Write-host   "Voer een geldige optie in."
            }
        }
 
    }
    
    clear
 
    Write-Host "=============Takenlijst================"
    $takenlijst
    Write-Host "#1 Taak toevoegen"
    Write-Host "#2 Taak verwijderen"
    Write-Host "#3 Taak aanpassen"
    Write-Host "#4 Taak afvinken"
    Write-Host "#5 Afvinken verwijderen"
    Write-Host "#6 Programma afsluiten"

}
