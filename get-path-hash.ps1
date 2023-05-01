param (
    [Parameter(Mandatory=$true)]
    [string] $Path
)

$item = Get-Item $Path

if ($item.PSIsContainer) {
    $hashString = (Get-ChildItem $Path -Recurse | Get-FileHash -Algorithm MD5).Hash | Out-String
    Get-FileHash -InputStream ([IO.MemoryStream]::new([char[]]$hashString))
} else {
    Get-FileHash -Path $Path
}