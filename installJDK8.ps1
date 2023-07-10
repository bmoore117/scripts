mkdir jdk
cp .\jdk-8u202-windows-x64.exe .\jdk
cd .\jdk
7z.exe e .\jdk-8u202-windows-x64.exe -y
7z.exe e .\111 -y
mkdir jdk8
Expand-Archive -Path .\tools.zip -DestinationPath .\jdk8
cd .\jdk8
$packs = Get-ChildItem -Recurse -Filter *.pack
foreach ($pack in $packs) {
    $newName = $pack.FullName.Substring(0, $pack.FullName.LastIndexOf(".")) + ".jar"
    .\bin\unpack200.exe -r $pack.FullName $newName
}

cd ..
mkdir $env:USERPROFILE\Programs -Force
cp .\jdk8 $env:USERPROFILE\Programs -Recurse
cd ..
Remove-Item .\jdk -Recurse