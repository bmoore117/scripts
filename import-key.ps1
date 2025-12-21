$certificates = Get-ChildItem $env:USERPROFILE\Downloads -Filter *.cer | Sort-Object -Descending -Property LastWriteTime
$certificate = $certificates[0]
$certName = $certificate.BaseName
$path = $certificate.FullName

$jdks = Get-ChildItem -Filter "jdk-*" -Path "$env:USERPROFILE\Programs"

foreach($jdk in $jdks) {
	$fullName = $jdk.FullName
	& "$fullName\bin\keytool.exe" "-importcert" "-trustcacerts" "-alias" "$certName" "-file" "$path" "-storepass" "changeit" "-noprompt" "-keystore" "$fullName\lib\security\cacerts"

}