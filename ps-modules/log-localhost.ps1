<#
  Script: Get-LocalhostListeners.ps1
  Purpose: Enumerate listening ports on localhost and export to CSV
  Author: Mel
  License: MIT
  Version: 1.0
#>

$results = Get-NetTCPConnection -State Listen | ForEach-Object {
    $proc = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue
    [PSCustomObject]@{
        Protocol   = $_.Protocol
        LocalPort  = $_.LocalPort
        LocalAddr  = $_.LocalAddress
        PID        = $_.OwningProcess
        Process    = if ($proc) { $proc.ProcessName } else { "Unknown" }
    }
}

# Export to CSV
$results | Export-Csv -Path ".\localhost_listeners.csv" -NoTypeInformation