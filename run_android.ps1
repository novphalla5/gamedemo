$ErrorActionPreference = 'Stop'

$env:GRADLE_USER_HOME = Join-Path $PSScriptRoot '.gradle-cache'

Set-Location -LiteralPath $PSScriptRoot
flutter run -d emulator-5554 -t lib\main.dart
