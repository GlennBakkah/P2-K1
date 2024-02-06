$path = "C:\Users\Quint\OneDrive\Bureaublad\School\Powershell\Documenten\Casus C\blacklist.json"

$data = Get-Content -Path $path

$json = $data | ConvertFrom-Json

foreach ($item in $json.services) {
    $service = Get-Service -DisplayName $item.Displayname
    if ($service.status -eq "Running") {
        Write-Host "Actieve blacklist service gevonden!"
        if ($item.threat -eq "High") { 
            Write-Host $service.Displayname "is een hoog risico en word uitgeschakeld..." -ForegroundColor Red
        }
        elseif ($item.threat -eq "Medium") {
            Write-Host $service.Displayname "is een middelmatig risico en word gerapporteerd..." -ForegroundColor DarkRed
        }
        elseif ($item.threat -eq "Low") {
            Write-Host $service.Displayname "is een laag risico, er word geen actie ondernomen..." -ForegroundColor Yellow
        }
        else { Write-Host "Er zijn geen risico's gevonden" }
    }
}
else { Write-Host "Er zijn geen risico's gevonden" }