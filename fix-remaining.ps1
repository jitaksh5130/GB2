# PowerShell script to fix remaining name mismatches
$htmlFile = "d:\GB\GB2-main\index.html"
$content = Get-Content $htmlFile -Raw -Encoding UTF8

# Fix remaining products with name mismatches
$fixes = @{
    # HTML data-name -> photo path
    'G Nova' = 'photos/page18_img0_68.jpeg'        # Was G-Nova in brochure
    'Jumbo +' = 'photos/page24_img0_86.jpeg'        # Was Jumbo+ (no space)
    'Super Mida' = 'photos/page28_img0_98.jpeg'     # Was Super-Mida (hyphen)
    'Green Mida' = 'photos/page22_img0_80.jpeg'     # Was Green-Minda (different spelling)
    'Super Lambda' = 'photos/page27_img0_95.jpeg'   # Was SuperLambda (no space)
    'Staretine' = 'photos/page56_img0_182.jpeg'     # Was Startine (different spelling)
}

$regex = [regex]'(?s)(data-category="([^"]*)"[^>]*data-name="([^"]*)"[^>]*>.*?<img\s+src=")([^"]*)(")'

$content = $regex.Replace($content, {
    param($m)
    $category = $m.Groups[2].Value
    $productName = $m.Groups[3].Value
    $currentSrc = $m.Groups[4].Value
    
    if ($fixes.ContainsKey($productName)) {
        $newSrc = $fixes[$productName]
        Write-Host "Fixed: $productName ($category) -> $newSrc"
        return "$($m.Groups[1].Value)$newSrc$($m.Groups[5].Value)"
    }
    
    return $m.Value
})

[System.IO.File]::WriteAllText($htmlFile, $content)
Write-Host "`nDone! Fixed additional name mismatches."
