function Test-PipeLineInput
{
[cmdletBinding()]
param(
    [Parameter(ValueFromPipeLine,ValueFromPipeLineByPropertyName)]
    [string]$Name,

    [Parameter(ValueFromPipeLineByPropertyName)]
    [string]$Status
)
Write-Host -Object "Value From PipeLine [string] $Name"
Write-Host -Object "Value From PipeLine By PropertyName $Status"
}

function Test-BeginProcessEnd
{
[cmdletBinding()]
param(
    [Parameter(ValueFromPipeLine,ValueFromPipeLineByPropertyName)]
    [string]$Name,

    [Parameter(ValueFromPipeLineByPropertyName)]
    [string]$Status
)
Begin
{
    Write-Host -Object "Start" -ForegroundColor Green
}
Process
{
    Write-Host -Object "Value From PipeLine [string] $Name"
    Write-Host -Object "Value From PipeLine By PropertyName $Status"
}
End
{
    Write-Host -Object "Ende" -ForegroundColor Green
}

}