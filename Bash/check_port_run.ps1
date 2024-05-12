param (
    [ValidateScript({
        if ($_ -as [int] -and $_ -gt 0 -and $_ -lt 65536) { $true } else { throw "Port number must be an integer between 1 and 65535." }
    })]
    [int]$port = (Read-Host "Enter the port number to check (e.g., 8080):")
)

try {
    $portOpen = $false

    $testResult = Test-NetConnection -ComputerName localhost -Port $port -InformationLevel Quiet
    if ($testResult -eq 'Success') {
        $portOpen = $true
    }

    if ($portOpen) {
        $pidT = (Get-NetTCPConnection -LocalPort $port).OwningProcess
        Get-WmiObject Win32_Process -Filter "ProcessId = $pidT" | Select-Object CommandLine
    } else {
        Write-Host "Port $port is not currently in use."
    }
} catch {
    Write-Host "An error occurred: $_"
}
