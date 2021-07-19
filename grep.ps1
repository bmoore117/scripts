Param(
    [Parameter(Mandatory=$false)]
    [String] $Path,
    [Parameter(Mandatory=$true)]
    [String] $Pattern,
    [Parameter(Mandatory=$false)]
    [switch] $FilenamesOnly
)

$files = $null

if ($Path) {
    $files = Get-ChildItem -Recurse -Path $Path | Where-Object {(Test-Path -Path $_.FullName -PathType Leaf) -eq $true}
} else {
    $files = Get-ChildItem -Recurse -Path . | Where-Object {(Test-Path -Path $_.FullName -PathType Leaf) -eq $true}
}

$results = $files | Select-String -Pattern ([regex]::Escape($Pattern))

if ($FilenamesOnly.IsPresent) {
    $results | Select-Object -Unique Path
} else {
    $results
}