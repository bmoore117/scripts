<#
.SYNOPSIS
Invokes the xAI Grok API with a given prompt, including the content of three CSV files inlined in the prompt.

.PARAMETER Prompt
The prompt to send to Grok.

.PARAMETER File1
Path to the first CSV file.

.PARAMETER File2
Path to the second CSV file.

.PARAMETER File3
Path to the third CSV file.

.PARAMETER ApiKey
Your xAI API key.

.PARAMETER Model
The Grok model to use (default: grok-3).

.EXAMPLE
.\Invoke-Grok.ps1 -Prompt "Analyze these CSV files and summarize key insights." -File1 "data1.csv" -File2 "data2.csv" -File3 "data3.csv" -ApiKey "your_api_key_here"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$Prompt,

    [Parameter(Mandatory=$true)]
    [string]$File1,

    [Parameter(Mandatory=$true)]
    [string]$File2,

    [Parameter(Mandatory=$false)]
    [string]$File3,

    [string]$Model = "grok-4"
)

# Read the CSV file contents as raw text
$csvContent1 = Get-Content -Path $File1 -Raw
$csvContent2 = Get-Content -Path $File2 -Raw

$fullPrompt = $null
if ($File3 -ne $null -and $File3 -ne "") {
    $csvContent3 = Get-Content -Path $File3 -Raw

    # Construct the full prompt with inlined CSV contents
    $fullPrompt = "$Prompt`n`n--- CSV File 1 Content ---`n$csvContent1`n`n--- CSV File 2 Content ---`n$csvContent2`n`n--- CSV File 3 Content ---`n$csvContent3"
} else {
    # Construct the full prompt with inlined CSV contents
    $fullPrompt = "$Prompt`n`n--- CSV File 1 Content ---`n$csvContent1`n`n--- CSV File 2 Content ---`n$csvContent2"
}


# Prepare the request body
$body = @{
    model = $Model
    messages = @(
        @{
            role = "user"
            content = $fullPrompt
        }
    )
} | ConvertTo-Json -Depth 3

# Prepare headers
$headers = @{
    Authorization = "Bearer $env:XAI_API_KEY"
    "Content-Type" = "application/json"
}

# Send the request
try {
    $response = Invoke-RestMethod -Uri "https://api.x.ai/v1/chat/completions" -Method Post -Headers $headers -Body $body
    # replace goddamn em dashes that llms love so much and which do not render properly in powershell 5.1
    Write-Output ($response.choices[0].message.content -replace "\u00e2", " - ")
} catch {
    Write-Error "Error invoking API: $_"
}