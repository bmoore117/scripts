param(
    [Parameter(Mandatory=$true)]
    [string]$Prompt,

    [Parameter(Mandatory=$false)]
    [string]$File1,

    [Parameter(Mandatory=$false)]
    [string]$File2,

    [Parameter(Mandatory=$false)]
    [string]$File3,

    [Parameter(Mandatory=$false)]
    [string]$Model = "grok-4",

    [Parameter(Mandatory=$false)]
    [switch]$UseLiveSearch,

    [Parameter(Mandatory=$false)]
    [switch]$RawFileContents
)

$fullPrompt = "$Prompt`n"

if ($File1 -ne $null -and $File1 -ne "") {
    if ($RawFileContents.IsPresent) {
        $fullPrompt = "$fullPrompt`n--- File 1 Content ---`n$File1"
    } else {
        $csvContent = Get-Content -Path $File1 -Raw
        $fullPrompt = "$fullPrompt`n--- CSV File 1 Content ---`n$csvContent"
    }
}

if ($File2 -ne $null -and $File2 -ne "") {
    if ($RawFileContents.IsPresent) {
        $fullPrompt = "$fullPrompt`n--- File 2 Content ---`n$File2"
    } else {
        $csvContent = Get-Content -Path $File2 -Raw
        $fullPrompt = "$fullPrompt`n--- CSV File 2 Content ---`n$csvContent"
    }
}

if ($File3 -ne $null -and $File3 -ne "") {
    if ($RawFileContents.IsPresent) {
        $fullPrompt = "$fullPrompt`n--- File 3 Content ---`n$File3"
    } else {
        $csvContent = Get-Content -Path $File3 -Raw
        $fullPrompt = "$fullPrompt`n--- CSV File 3 Content ---`n$csvContent"
    }
}

$date = Get-Date
$isoDateString = Get-Date -Date $date -UFormat "%Y-%m-%d"


$body = $null
if ($UseLiveSearch.IsPresent) {
    $body = @{
        model = $Model
        messages = @(
            @{
                role = "user"
                content = $fullPrompt
            }
        )
        search_parameters = @{
            mode = "on"
            to_date = $isoDateString
            sources = @(
                @{
                    type = "web"
                },
                @{
                    type = "x"
                },
                @{
                    type = "news"
                }
            )
        }
    } | ConvertTo-Json -Depth 10
} else {
    $body = @{
        model = $Model
        messages = @(
            @{
                role = "user"
                content = $fullPrompt
            }
        )
     } | ConvertTo-Json -Depth 100
}



if ($RawFileContents.IsPresent) {
    # ConvertTo-Json unfortunately mucks up the string with these unicode representations rather than leaving the characters in
    # which are perfectly valid. Re-un-escape them, and ascii-fy string, as it will have the unicode curse (tm) on it
    $body = $body -replace "\\u0027", "'"
    $body = $body -replace "\\u003e", ">"
    $body = $body -replace "\\u003c", "<"
    $body = $body -replace "\\u0026", "&"
    
    $bytes = [System.Text.Encoding]::ASCII.GetBytes($body)
    $body = [System.Text.Encoding]::ASCII.GetString($bytes)
}

# Prepare headers
$headers = @{
    Authorization = "Bearer $env:XAI_API_KEY"
    "Content-Type" = "application/json"
}

# Send the request
try {
    $response = Invoke-RestMethod -Uri "https://api.x.ai/v1/chat/completions" -Method Post -Headers $headers -Body $body
    # replace goddamn em dashes that llms love so much and which do not render properly in powershell 5.1
    $asciiFied = $response.choices[0].message.content -replace "\u00e2", " - "
    Write-Output $asciiFied
} catch {
    Write-Error "Error invoking API: $_"
}