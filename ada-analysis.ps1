$date = Get-Date
$isoDateString = Get-Date -Date $date -UFormat "%Y-%m-%d"
$data = Get-Content "~\Documents\Rainmeter\Skins\trademeter\ADA\data-$isoDateString.csv" -Raw | ConvertFrom-Csv

$date = $data[0].Date

$prompt = "these files contain Cardano (ADA) OHLCV data from $date to the present, as well as Market Value to Realized Value ratio for the last 14 days. Provide your analysis of this data and advise whether you think the market will continue downwards, level off, or begin to trend upwards. Specifically, provide a Short-Term (next 1-2 weeks) view and a Medium-Term (next 1-3 months) view."

analysis.ps1 -Prompt $prompt -File1  "~\Documents\Rainmeter\Skins\trademeter\ADA\data-$isoDateString.csv" -File2 "~\Documents\Rainmeter\Skins\trademeter\ADA\data-mvrv-$isoDateString.csv"