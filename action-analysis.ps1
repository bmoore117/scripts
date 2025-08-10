$adaAnalysis =  ~\Programs\scripts\ada-analysis.ps1
$btcAnalysis = ~\Programs\scripts\btc-analysis.ps1
$newsAnalysis = ~\Programs\scripts\news-analysis.ps1

$prompt = 'The following files contain an analysis of Cardano ADA price action, BTC price action, and expected news and events related to cryptocurrency over the next 3 months. Read through them and, looking forwards over the next week, offer either a recommendation to convert a hypothetical ADA portfolio to stablecoins, or convert a hypothetical stablecoin portfolio to ADA. Phrase as "Long ADA" or "Stable Up", and assign a confidence score from 0-100'

~\Programs\scripts\analysis.ps1 -Prompt $prompt -File1 $adaAnalysis -File2 $btcAnalysis -File3 $newsAnalysis -RawFileContents