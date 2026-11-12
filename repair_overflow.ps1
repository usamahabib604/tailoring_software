$File = "D:\tailoring_software\lib\main.dart"

$code = Get-Content $File -Raw

# Confirm Order dialog ke bottom buttons ke liye thori extra space
$code = $code -replace "height:\s*46", "height: 42"

Set-Content -Path $File -Value $code -Encoding UTF8

Write-Host ""
Write-Host "DONE: Confirm Order bottom area adjusted." -ForegroundColor Green
Write-Host ""
flutter analyze
