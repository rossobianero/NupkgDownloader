﻿
$ErrorActionPreference = 'Stop';
$PackageDir = Split-Path -Parent $PSScriptRoot
$AllUsersModuleDir = Join-Path $env:ProgramFiles "/PowerShell/Modules/VerintPM"

New-Item $AllUsersModuleDir/src -ItemType Directory -Force | Out-Null
Copy-Item $PackageDir/src/* $AllUsersModuleDir/src
Copy-Item $PackageDir/VerintPM.ps* $AllUsersModuleDir

# In case we are manually installing, we replace the version token with a dummy number.

$versionToken = "#{MajorMinorPatch}#"
$psd = Get-Content $AllUsersModuleDir/VerintPM.psd1 -Raw
if ($psd.Contains($versionToken)) {
	$psd -Replace $versionToken,"1.0" | Set-Content $AllUsersModuleDir/VerintPM.psd1
}
