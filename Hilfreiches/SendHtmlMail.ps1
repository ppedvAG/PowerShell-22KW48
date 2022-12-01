
$a = "<style>"
$a = $a + "BODY{background-color:peachpuff;}"
$a = $a + "TABLE{border-width: 1px; border-style: solid; border-color: black; border-collapse: collapse;}"
$a = $a + "TH{border-width: 1px; padding: 0px; border-style: solid; border-color: black; background-color:thistle}"
$a = $a + "TD{border-width: 1px; padding: 0px; border-style: solid; border-color: black; background-color:yellowgreen}"
$a = $a + "</style"

$html = Get-Service | Select-Object -Property Status,NAme,DisplayNAme | ConvertTo-Html -Head $a -Body "<H2>DienstInfos</H2>"

Out-File -InputObject $html -FilePath C:\test.html
Send-MailMessage -Body $html 