$date = Get-Date
$isoDateString = Get-Date -Date $date -UFormat "%Y-%m-%d"

analysis.ps1 -Prompt "looking forward from today's date of $isoDateString, what are the top 3 major events that could impact the price of cryptocurrency? Provide a view over the next two weeks, as well as a separate view over the next three months. Analyze macroeconomic and monetary policy events, regulatory and political events, as well as crypto-specific events, and provide a concise summary. Ignore crypto events that aren't relevant to Bitcoin or Cardano" -UseLiveSearch