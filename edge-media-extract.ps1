md "$env:USERPROFILE\Pictures\edge-extract" -ea 0

$files = Get-ChildItem -Recurse -Path "$env:USERPROFILE\AppData\Local\Microsoft\Edge\User Data\Default\Cache\Cache_Data" | Where-Object {(Test-Path -Path $_.FullName -PathType Leaf) -eq $true}

foreach($file in $files) {
	$name = $file.Name
	if ((Select-String -Path $file.FullName -Pattern ([regex]::Escape("WEBPVP8")) -ErrorAction SilentlyContinue) -ne $null) {
		cp $file.FullName "$env:USERPROFILE\Pictures\edge-extract\$name.webp"
	} elseif ((Select-String -Path $file.FullName -Pattern ([regex]::Escape("JPG")) -ErrorAction SilentlyContinue) -ne $null) {
		cp $file.FullName "$env:USERPROFILE\Pictures\edge-extract\$name.jpg"
	} elseif ((Select-String -Path $file.FullName -Pattern ([regex]::Escape("JPEG")) -ErrorAction SilentlyContinue) -ne $null) {
		cp $file.FullName "$env:USERPROFILE\Pictures\edge-extract\$name.jpeg"
	} elseif ((Select-String -Path $file.FullName -Pattern ([regex]::Escape("JFIF")) -ErrorAction SilentlyContinue) -ne $null) {
		cp $file.FullName "$env:USERPROFILE\Pictures\edge-extract\$name.jfif"
	} elseif ((Select-String -Path $file.FullName -Pattern ([regex]::Escape("PNG")) -ErrorAction SilentlyContinue) -ne $null) {
		cp $file.FullName "$env:USERPROFILE\Pictures\edge-extract\$name.png"
	} elseif ((Select-String -Path $file.FullName -Pattern ([regex]::Escape("mp4")) -ErrorAction SilentlyContinue) -ne $null) {
		cp $file.FullName "$env:USERPROFILE\Pictures\edge-extract\$name.mp4"
	}
}