md "$env:USERPROFILE\Pictures\firefox-extract" -ea 0

$files = Get-ChildItem -Recurse -Path "$env:USERPROFILE\AppData\Local\Packages\Mozilla.Firefox_n80bbvh6b1yt2\LocalCache\Local\Mozilla\Firefox\Profiles\q2zs7vbv.default-release\cache2\entries" | Where-Object {(Test-Path -Path $_.FullName -PathType Leaf) -eq $true}

foreach($file in $files) {
	$name = $file.Name
	if ((Select-String -Path $file.FullName -Pattern ([regex]::Escape("WEBPVP8")) -ErrorAction SilentlyContinue) -ne $null) {
		cp $file.FullName "$env:USERPROFILE\Pictures\firefox-extract\$name.webp"
	} elseif ((Select-String -Path $file.FullName -Pattern ([regex]::Escape("JPG")) -ErrorAction SilentlyContinue) -ne $null) {
		cp $file.FullName "$env:USERPROFILE\Pictures\firefox-extract\$name.jpg"
	} elseif ((Select-String -Path $file.FullName -Pattern ([regex]::Escape("JPEG")) -ErrorAction SilentlyContinue) -ne $null) {
		cp $file.FullName "$env:USERPROFILE\Pictures\firefox-extract\$name.jpeg"
	} elseif ((Select-String -Path $file.FullName -Pattern ([regex]::Escape("JFIF")) -ErrorAction SilentlyContinue) -ne $null) {
		cp $file.FullName "$env:USERPROFILE\Pictures\firefox-extract\$name.jfif"
	} elseif ((Select-String -Path $file.FullName -Pattern ([regex]::Escape("PNG")) -ErrorAction SilentlyContinue) -ne $null) {
		cp $file.FullName "$env:USERPROFILE\Pictures\firefox-extract\$name.png"
	} elseif ((Select-String -Path $file.FullName -Pattern ([regex]::Escape("mp4")) -ErrorAction SilentlyContinue) -ne $null) {
		cp $file.FullName "$env:USERPROFILE\Pictures\firefox-extract\$name.mp4"
	}
}