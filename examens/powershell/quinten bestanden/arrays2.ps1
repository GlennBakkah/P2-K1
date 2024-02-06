$array = Get-Process

foreach ($item in $array){
    Write-Host $item.name
    if ($item.name -eq "msedge"){
        Write-Host $item.Name -ForegroundColor Green
    }
}