$File = "D:\tailoring_software\lib\main.dart"

if (-not (Test-Path $File)) {
    Write-Host "ERROR: main.dart nahi mili." -ForegroundColor Red
    exit
}

$code = Get-Content $File -Raw

# ============================================================
# CONFIRM ORDER - MAIN HEADINGS REMOVE
# ============================================================

$oldPanel = @"
  Widget _checkPanel({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 1,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 1),
          child,
        ],
      ),
    );
  }
"@

$newPanel = @"
  Widget _checkPanel({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 1,
      ),
      child: child,
    );
  }
"@

if ($code.Contains($oldPanel)) {
    $code = $code.Replace($oldPanel, $newPanel)
    Write-Host "DONE: Confirm Order ke main headings remove kar di gayi hain." -ForegroundColor Green
}
else {
    Write-Host "WARNING: Target code nahi mila. File ko change nahi kiya gaya." -ForegroundColor Yellow
}

Set-Content -Path $File -Value $code -Encoding UTF8

Write-Host ""
Write-Host "Flutter analyze chala raha hoon..." -ForegroundColor Cyan
flutter analyze

Write-Host ""
Write-Host "REPAIR COMPLETE." -ForegroundColor Green
