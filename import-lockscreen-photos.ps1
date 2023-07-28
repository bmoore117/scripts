if (-not (Test-Path ~\Pictures\lockscreen)) {
    mkdir ~\Pictures\lockscreen
}
cp "$env:LOCALAPPDATA\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\*" ~\Pictures\lockscreen

$items = Get-ChildItem ~\Pictures\lockscreen | Where-Object {$_ -isnot [IO.DirectoryInfo]}
foreach ($item in $items) {
    if (-not $item.FullName.EndsWith(".jpg")) {
        mv $item.FullName ($item.FullName + ".jpg") -Force
    }
}

