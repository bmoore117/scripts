$certificates = Get-ChildItem $env:USERPROFILE\Downloads -Filter *.cer | Sort-Object -Descending -Property LastWriteTime
$certificate = $certificates[0]
$certName = $certificate.BaseName
$path = $certificate.FullName

& "$env:USERPROFILE\Programs\jdk-11.0.11\bin\keytool.exe" "importcert" "-trustcacerts" "-alias" "$certName" "-file" "$path" "-storepass" "changeit" "-noprompt" "-keystore" "$env:USERPROFILE\Programs\jdk-11.0.11\lib\security\cacerts"