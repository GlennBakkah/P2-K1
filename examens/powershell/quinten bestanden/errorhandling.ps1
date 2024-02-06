$error.Clear()

function process() {
    $id = Read-Host "Geef het id nummer op van uw process"

    try {
        Get-Process -id $id
    }
    catch [System.Exception] {
        Write-Host $_
        Write-Host "Error wrong ID"
    }
    if ($Error.Count -gt 0) {
        Write-Host "Wadafak man, bel de ICT dienst"
    }

}

process