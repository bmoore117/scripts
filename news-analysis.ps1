$isoDateString = Get-Date -UFormat "%Y-%m-%d"

$ada24HrChg = Import-Csv ~\Documents\Rainmeter\Skins\trademeter\Ticker\data-ada.csv
$ada24HrChg = [double]$ada24HrChg.DayChange
$adaStatus = $null
if ($ada24hrChg -gt 0) {
	$adaStatus = "up"
} else {
	$adaStatus = "down"
}

$btc24HrChg = Import-Csv ~\Documents\Rainmeter\Skins\trademeter\Ticker\data-btc.csv
$btc24HrChg = $btc24HrChg.DayChange
$btcStatus = $null
if ($btc24hrChg -gt 0) {
	$btcStatus = "up"
} else {
	$btcStatus = "down"
}

$recentPastResults = analysis.ps1 -Prompt "what has affected crypto prices the most over the past two days? Bear in mind that BTC is $btcStatus $btc24HrChg% over the last 24 hours and ADA is $adaStatus $ada24HrChg%" -UseLiveSearch

$weekResults = analysis.ps1 -Prompt "looking forward from today's date of $isoDateString, what are the top 3 major events that could impact the price of cryptocurrency? Provide a view over the next two weeks. Analyze macroeconomic and monetary policy events, regulatory and political events, as well as crypto-specific events, and provide a concise summary including whether the event is expected to be bullish or bearish. Ignore crypto events that aren't relevant to Bitcoin or Cardano" -UseLiveSearch

$monthResults = analysis.ps1 -Prompt "looking forward from today's date of $isoDateString, what are the top 3 major events that could impact the price of cryptocurrency? Provide a view over the next two months. Analyze macroeconomic and monetary policy events, regulatory and political events, as well as crypto-specific events, and provide a concise summary including whether the event is expected to be bullish or bearish. Ignore crypto events that aren't relevant to Bitcoin or Cardano" -UseLiveSearch

"Below are some news analyses of the most recent price action, a view over the next two weeks, and a view over the next two months.`n`n# Last two days`n`n$recentPastResults`n`n# Next two weeks`n`n$weekResults`n`n# Next two months`n`n$monthResults"