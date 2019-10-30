param(
   [Parameter(Mandatory=$true)][String]$ServerActive,
   [Parameter(Mandatory=$true)][String]$ClientHostname
)
Write-Host "Generating package for Proxy $ServerActive and client name $ClientHostname"
$PreparedDirName = "prepared-$ClientHostname"
$PreparedDir = "$PSScriptRoot\$PreparedDirName"

if (Test-Path -Path "$PreparedDir") {
	Remove-Item -LiteralPath "$PreparedDir" -Force -Recurse
}
#if (Test-Path -Path "$PSScriptRoot\compiled") {
#	Remove-Item -LiteralPath "$PSScriptRoot\compiled" -Force -Recurse
#}
$result = New-Item -ItemType directory -Path "$PreparedDir"

Copy-Item -Path "$PSScriptRoot\source\*" -Filter "*" -Recurse -Destination "$PreparedDir" -Container

((Get-Content -path "$PreparedDir\conf\rtmonitor.conf" -Raw) -replace '__active_server__', "$ServerActive") | Set-Content -Path "$PreparedDir\conf\rtmonitor.conf"
((Get-Content -path "$PreparedDir\conf\rtmonitor.conf" -Raw) -replace '__hostname__', "$ClientHostname") | Set-Content -Path "$PreparedDir\conf\rtmonitor.conf"

Copy-Item -Path "$PSScriptRoot\make_package.iss"  -Recurse -Destination "$PreparedDir"

& "$PSScriptRoot\InnoSetup6\iscc.exe" "/Dprepared=$PreparedDirName" /Qp /O"$PSScriptRoot\compiled" /F"RTMonitor-setup-$ClientHostname"  "$PreparedDir\make_package.iss"

if (Test-Path -Path "$PreparedDir") {
	Remove-Item -LiteralPath "$PreparedDir" -Force -Recurse
}