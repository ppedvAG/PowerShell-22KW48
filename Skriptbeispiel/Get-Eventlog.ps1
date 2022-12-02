<#
.SYNOPSIS
    Kurzbeschreibung: Abfrage von Events
.DESCRIPTION
    Lange BEschreibung: Dieses Skript dient dazu Events die mit Anmeldungen zu tun haben abzufragen aus dem EventLog Security
.PARAMETER EventId
    4624 : Anmeldung
    4625 : fehlgeschlagene Anmeldung
    4634 : Abmeldung
.EXAMPLE
Get-Eventlog.ps1 -EventId 4624

 Index Time          EntryType   Source                 InstanceID Message
 ----- ----          ---------   ------                 ---------- -------
345888 Dez 01 13:40  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
345885 Dez 01 13:40  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
345881 Dez 01 13:40  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
345879 Dez 01 13:40  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
345877 Dez 01 13:40  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....

Frägt das Event 4624 (Anmeldung) VOm Eventlog ab und gibt standardmäßig die aktuellesten 5 Events aus
.EXAMPLE
Get-Eventlog.ps1 -EventId 4624 -Verbose
AUSFÜHRLICH: Wird nur ausgegeben wenn das Skript mit dem Parameter -Verbose ausgeführt wird
AUSFÜHRLICH: EventId: 4624
AUSFÜHRLICH: Newest: 5
AUSFÜHRLICH: ComputerName: localhost

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
  345896 Dez 01 13:40  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  345893 Dez 01 13:40  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  345888 Dez 01 13:40  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  345885 Dez 01 13:40  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
  345881 Dez 01 13:40  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....

  Wenn der Parameter -Verbose verwendet wird werden weitere ausführliche Informationen ausgegeben
.LINK
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-5.1
.NOTES
 Author: StefanO@ppedv.de
#>
[cmdletBinding()]
param(

[Parameter(Mandatory=$true)]
[ValidateSet(4624,4625,4634)]
[int]$EventId,

[ValidateRange(5,10)]
[int]$Newest = 5,

[ValidateScript({Test-NetConnection -ComputerName $PSItem -CommonTCPPort WINRM -InformationLevel Quiet})]
[string]$ComputerName = "localhost"
)

Write-Verbose -Message "Wird nur ausgegeben wenn das Skript mit dem Parameter -Verbose ausgeführt wird"
Write-Verbose -Message "EventId: $eventid"
Write-Verbose -Message "Newest: $Newest"
Write-Verbose -Message "ComputerName: $ComputerName"

Write-Debug -Message "Debug Haltepunkt Vor Abfrage"

Get-EventLog -LogName Security -ComputerName $ComputerName | Where-Object EventId -eq $EventId | Select-Object -First $Newest
