[cmdletBinding()]
param(

[Parameter(Mandatory=$true)]
[ValidateScript({Test-Path -Path $PSItem -PathType Container })]
[string]$Path,

[ValidateLength(2,20)]
[string]$Name = "TestFiles2",

[ValidateRange(0,100)]
[int]$DirCount = 3,

[ValidateRange(0,100)]
[int]$FileCount = 9,

[switch]$Force
)
#Functions
function New-TestFiles
{
[cmdletBinding()]
param(
[Parameter(Mandatory=$true)]
[string]$Path,

[int]$FileCount = 9,

[string]$BaseName = "File"
)
    for($i = 1; $i -le $FileCount; $i++)
    {
        $FileName = $BaseName + ("{0:D3}" -f $i) + ".txt"

        New-Item -Path $Path -Name $FileName -ItemType File
    }
}
#Ende Functions


if($Path.EndsWith("\"))
{
    $TestFilesDir = $Path + $Name
}
else
{
    $TestFilesDir = $Path + "\" + $Name
}

<#
In dem folgenden IF Statement wird geprüft ob der ORdner vorhanden ist
Wenn der Ordner vorhanden ist und das Skript mit dem Switch Parameter -Force aufgerufen wird , wird das Verzeichnis gelöscht
Anderfalls wird eine Meldung ausgegeben
#>#Beschreibung zum Block
if(Test-Path -Path $TestFilesDir)
{
    Write-Verbose -Message "Ordner $TestFilesDir bereits vorhanden"
    if($Force)
    {
        Write-Verbose -Message "Ordner wird gelöscht"
        Remove-Item -Path $TestFilesDir -Force -Recurse
    }
    else
    {
        Write-Host -Object "Ordner bereits vorhanden"
        exit
    }
}

$TestFiles = New-Item -Path $Path -Name $Name -ItemType Directory

New-TestFiles -Path $TestFiles.FullName -FileCount $FileCount

for($i = 1; $i -le $DirCount; $i++)
{
    $DirName = "Directory" + ("{0:D3}" -f $i)
    $SubDir = New-Item -Path $TestFiles.FullName -Name $DirName -ItemType Directory

    New-TestFiles -Path $SubDir.FullName -FileCount $FileCount 
}
