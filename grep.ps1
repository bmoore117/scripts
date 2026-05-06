Param(
    [Parameter(Mandatory=$true,Position=0)]
    [String] $Pattern,
    [Parameter(Mandatory=$false)]
    [String] $Path,
    [Parameter(Mandatory=$false)]
    [String] $Filter,
    [Parameter(Mandatory=$false)]
    [switch] $DisplayFilenamesOnly
)

$files = $null

if ($Path) {
    if ($Filter) {
        $files = Get-ChildItem -Recurse -Path $Path -Filter $Filter | Where-Object {(Test-Path -Path $_.FullName -PathType Leaf) -eq $true}
    } else {
        $files = Get-ChildItem -Recurse -Path $Path | Where-Object {(Test-Path -Path $_.FullName -PathType Leaf) -eq $true}
    }
} else {
    if ($Filter) {
        $files = Get-ChildItem -Recurse -Path . -Filter $Filter | Where-Object {(Test-Path -Path $_.FullName -PathType Leaf) -eq $true}
    } else {
        $files = Get-ChildItem -Recurse -Path . | Where-Object {(Test-Path -Path $_.FullName -PathType Leaf) -eq $true}
    }
}

$results = $files | Select-String -Pattern ([regex]::Escape($Pattern))

if ($DisplayFilenamesOnly.IsPresent) {
    $results | Select-Object -Unique Path
} else {
    $results
}