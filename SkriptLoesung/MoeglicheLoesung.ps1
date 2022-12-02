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

if($Path.EndsWith("\"))
{
    $TestFilesDir = $Path + $Name
}
else
{
    $TestFilesDir = $Path + "\" + $Name
}
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
        throw "Ordner bereits vorhanden"
    }
}

$TestFiles = New-Item -Path $Path -Name $Name -ItemType Directory

for($i = 1; $i -le $DirCount; $i++)
{
    $DirName = "Directory" + ("{0:D3}" -f $i)
    $SubDir = New-Item -Path $TestFiles.FullName -Name $DirName -ItemType Directory

    for($j = 1; $j -le $FileCount; $j++)
    {
        $FileName = "File" + ("{0:D3}" -f $j) + ".txt"

        New-Item -Path $SubDir.FullName -Name $FileName -ItemType File
    }
}

for($i = 1; $i -le $FileCount; $i++)
{
    $FileName = "File" + ("{0:D3}" -f $i) + ".txt"

    New-Item -Path $TestFiles.FullName -Name $FileName -ItemType File 
}
