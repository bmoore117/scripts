Param(
    [Parameter(Mandatory=$true)]
    [String] $Path
)

$c = (Get-Content -Path $Path)
[array]::Reverse($c)

$endPath = $Path
if ($Path.StartsWith(".\")) {
    $endPath = $endPath.Substring(2)
}

$c | Out-File "rev-$endPath"