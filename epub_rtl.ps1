
$tempDir = New-TemporaryFile | %{ rm $_; mkdir $_ }
$epub = "$Args"
echo "epub: $epub"
Expand-Archive $epub -DestinationPath $tempDir
$content = $(cat "$tempDir/content.opf") -replace '<spine toc="ncx">',
  '<spine toc="ncx" page-progression-direction="rtl">'
$content > "$tempDir/content.opf"
$new_epub = $epub -replace "\.epub$", "_rtl.epub"
Compress-Archive "$tempDir/*" -Force -DestinationPath $new_epub

$tempDir | ? { Test-Path $_ } | % { ls $_ -File -Recurse | rm; $_} | rmdir -Recurse
