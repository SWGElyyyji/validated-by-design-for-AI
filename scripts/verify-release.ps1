$ErrorActionPreference = "Stop"

$repositoryRoot = Split-Path -Parent $PSScriptRoot

$failures = [System.Collections.Generic.List[string]]::new()

$releases = @(
    @{
        Version = "v1.0.0"
        Book = "1"
        Pdf = "validated-by-design-for-ai-book-1-v1.0.0.pdf"
    },
    @{
        Version = "v1.0.1"
        Book = "1"
        Pdf = "validated-by-design-for-ai-book-1-v1.0.1.pdf"
    },
    @{
        Version = "v1.0.2"
        Book = "1"
        Pdf = "validated-by-design-for-ai-book-1-v1.0.2.pdf"
    }
)

Write-Host ""
Write-Host "Validated-by-Design for AI"
Write-Host "Release Verification"
Write-Host "------------------------------"

foreach ($release in $releases) {

    $version = $release.Version
    $book = $release.Book
    $pdfName = $release.Pdf

    Write-Host ""
    Write-Host "Checking Book $book - $version"

    $releaseDirectory = Join-Path $repositoryRoot "releases/$version"

    $pdfPath = Join-Path $releaseDirectory $pdfName

    $notesPath = Join-Path $releaseDirectory "RELEASE-NOTES.md"

    $checksumPath = Join-Path $releaseDirectory "SHA256SUMS.txt"

    if (-not (Test-Path -LiteralPath $pdfPath -PathType Leaf)) {
        $failures.Add("Missing PDF: $pdfPath")
    }

    if (-not (Test-Path -LiteralPath $notesPath -PathType Leaf)) {
        $failures.Add("Missing release notes: $notesPath")
    }

    if (-not (Test-Path -LiteralPath $checksumPath -PathType Leaf)) {
        $failures.Add("Missing checksum file: $checksumPath")
    }

    if (
        (Test-Path -LiteralPath $pdfPath -PathType Leaf) -and
        (Test-Path -LiteralPath $checksumPath -PathType Leaf)
    ) {

        $checksumText = Get-Content -LiteralPath $checksumPath -Raw

 $escapedPdfName = [regex]::Escape($pdfName)

        $checksumPattern = "(?im)^\s*([A-Fa-f0-9]{64})\s+\*?$escapedPdfName\s*$"

        if ($checksumText -match $checksumPattern) {

            $expectedHash = $matches[1].ToUpperInvariant()

            $actualHash = (
                Get-FileHash -LiteralPath $pdfPath -Algorithm SHA256
            ).Hash.ToUpperInvariant()

            if ($expectedHash -ne $actualHash) {
                $failures.Add("Checksum mismatch: $pdfName")
            }
            else {
                Write-Host "PDF checksum verified." -ForegroundColor Green
            }

        }
        else {
            $failures.Add("Invalid checksum entry: $pdfName")
        }
    }
}

$requiredFiles = @(
    "README.md",
    "index.html",
    "CITATION.cff",
    ".zenodo.json",
    "CHANGELOG.md",
    "PUBLISHING.md",
    "LICENSE"
)

foreach ($file in $requiredFiles) {

    $path = Join-Path $repositoryRoot $file

    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        $failures.Add("Missing repository file: $file")
    }
}

if ($failures.Count -gt 0) {

    Write-Host ""
    Write-Host "Release verification FAILED" -ForegroundColor Red

    foreach ($failure in $failures) {
        Write-Host " - $failure" -ForegroundColor Red
    }

    exit 1
}

Write-Host ""
Write-Host "Release verification PASSED" -ForegroundColor Green

exit 0