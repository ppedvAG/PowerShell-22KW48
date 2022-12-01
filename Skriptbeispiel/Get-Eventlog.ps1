param(

[Parameter(Mandatory=$true)]
[int]$EventId,

[int]$Newest = 5,

[string]$ComputerName = "localhost"
)

Get-EventLog -LogName Security -ComputerName $ComputerName | Where-Object EventId -eq $EventId | Select-Object -First $Newest
