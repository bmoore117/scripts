param (
    [Parameter(Position=0)]
    [string]$DataUrl,
    [Parameter(Position=1)]
    [string]$SavePath
)

$data = Get-Content $DataUrl -Raw    
$match = [regex]::Match($data, 'data:([\w\/]+)?;base64,(.+)$')
$base64Data = $match.Groups[2].Value
$binData = [Convert]::FromBase64String($base64Data)
[System.IO.File]::WriteAllBytes($SavePath, $binData)