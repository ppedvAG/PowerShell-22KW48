[cmdletBinding()]
param(
[Parameter(Mandatory=$true)]
[ValidateLength(5,100)]
[string]$Text
)

if((Get-Service -Name Audiosrv).Status -ne "Running")
{
    Start-Service -Name Audiosrv
}

Add-Type -AssemblyName System.Speech
$speaker = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer

$speaker.Speak($Text)
