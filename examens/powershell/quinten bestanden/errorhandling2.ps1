$error.Clear()

function Get-MyApp-DiskInfo() {
    [Cmdletbinding()]
    param (
        [Parameter(Mandatory = $true)]
        [int]$DiskNummer,
        [Parameter(Mandatory = $true)]
        [string]$Unit
    )

    if ($DiskNummer -ge 0 -and $DiskNummer -lt 5) {
        try {
            $Disk = Get-Disk $DiskNummer -ErrorAction Stop
        }
        catch [System.Exception] {
            Write-Host "Ongeldig disknummer"
            exit
        }
    }
    else {
        Write-Host "Getal is niet tussen 0 en 5"
    }
    

    if ($Unit -eq "megabyte") {
        return $Disk.size / 1024 / 1024 #Megabytes
    }
    
    elseif ($Unit -eq "gigabyte") {
        return $Disk.size / 1024 / 1024 / 1024 #Gigabytes
    } 
    elseif ($Unit -eq "byte") {
        return $Disk.size #bytes
    }
    else {
        Write-Host "Ongeldige eenheid"
    }
    
    
    
}

$Disknummer = Read-Host "Welk disknummer wilt u de groote van weten?"
$Eenheid = Read-Host "In welke eenheid wilt u deze bekijken? (gigabyte, megabyte of byte)"



try {
    Get-MyApp-DiskInfo $Disknummer -Unit $Eenheid
}
catch [System.Exception] {
    Write-Host $_
    exit
}



