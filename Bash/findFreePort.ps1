$count = 0
$start_port = 8001

while ($count -lt 3) {
    $port = $start_port + (Get-Random -Minimum 0 -Maximum 57534)
    $netstatResult = netstat -a -n -o | Select-String -Pattern ("[[:space:]]" + $port + "[[:space:]]")

    if (-not $netstatResult) {
        Write-Output "Port $port is free"
        $count++
    } else {
        $count++
    }

    if ($count -eq 3) {
        break
    }
}

pause
