Param(
    [Parameter(Mandatory=$true)]
    [String] $User,
    [Parameter(Mandatory=$true)]
    [String] $Folder,
    [Parameter(Mandatory=$true)]
    [String] $TaskName
)

# Example Usage
# .\grant-nonadmin-task.ps1 -User "moore" -Folder "\" -TaskName "Update Steam Games"

$account = New-Object System.Security.Principal.NTAccount($User)  
$SID=$account.Translate([System.Security.Principal.SecurityIdentifier]).Value
$TaskScheduler = New-Object -ComObject Schedule.Service
$TaskScheduler.Connect()
$Task = $TaskScheduler.GetFolder($Folder).GetTask($TaskName)  
$sec=$task.GetSecurityDescriptor(0xF)
$sec=$sec + "(A;;GRGX;;;$SID)"  
$Task.SetSecurityDescriptor($sec, 0)