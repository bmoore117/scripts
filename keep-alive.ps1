Clear-Host
Write-Host "Keep-alive with Scroll Lock..."

$shell = New-Object -ComObject "Wscript.Shell"

while ($true) {
    $shell.sendkeys("{SCROLLLOCK}")
    Start-Sleep -Milliseconds 100
    $shell.sendkeys("{SCROLLLOCK}")
    Start-Sleep -Seconds 240
}