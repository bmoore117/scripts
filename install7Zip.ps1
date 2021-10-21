msiexec.exe /i 7z1900-x64.msi MSIINSTALLPERUSER=1

$userPath = (Get-ItemProperty -Path HKCU:\Environment\ -Name Path).Path
if (-not ($userPath -split ";").Contains("$env:USERPROFILE\Programs\7-Zip")) {
    if ($userPath.EndsWith(";")) {
        Set-ItemProperty -Path HKCU:\Environment\ -Name Path -Value "$userPath$env:USERPROFILE\Programs\7-Zip"
    } else {
        Set-ItemProperty -Path HKCU:\Environment\ -Name Path -Value "$userPath;$env:USERPROFILE\Programs\7-Zip"
    }
}