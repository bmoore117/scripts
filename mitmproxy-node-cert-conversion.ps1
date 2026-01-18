# DER .cer -> PEM .pem (PowerShell/.NET, no OpenSSL)

$in  = "$env:USERPROFILE\Programs\mitmproxy.cer"   # DER-encoded cert
$out = "$env:USERPROFILE\Programs\mitmproxy.pem"   # PEM output

$bytes = [System.IO.File]::ReadAllBytes($in)
$b64   = [System.Convert]::ToBase64String($bytes)

$lines = @("-----BEGIN CERTIFICATE-----")
for ($i = 0; $i -lt $b64.Length; $i += 64) {
  $lines += $b64.Substring($i, [Math]::Min(64, $b64.Length - $i))
}
$lines += "-----END CERTIFICATE-----"

[System.IO.File]::WriteAllLines($out, $lines)

Write-Host "Set NODE_EXTRA_CA_CERTS = $out"