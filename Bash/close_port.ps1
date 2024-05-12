param (
    [string]$port = (Read-Host "Enter the port number to close (e.g., 8080):")
)

$portOpen = $false

# Check if the port is open
$netstatResult = netstat -ano | Select-String ":$port"
if ($netstatResult) {
    $portOpen = $true
}

# If the port is open, prompt the user to close it
if ($portOpen) {
    Write-Host "Port $port is currently in use. Do you want to close it? (Y/N)"
    $choice = Read-Host
    if ($choice.ToUpper() -eq "Y") {
        $pidT = ($netstatResult -split '\s+')[4]
        Stop-Process -Id $pidT -Force
        Write-Host "Port $port has been closed."
    } else {
        Write-Host "Port $port will not be closed."
    }
} else {
    Write-Host "Port $port is not currently in use."
}

pause
