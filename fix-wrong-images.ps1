# PowerShell script to fix the 10 wrong product-image mappings
$htmlFile = "d:\GB\GB2-main\index.html"
$content = Get-Content $htmlFile -Raw -Encoding UTF8

# Corrections needed:
# 1. Carbo Power currently has page10 (Stiny) -> revert to images/carbo-power.png
# 2. Growset currently has page11 (Batman) -> revert to images/carbo-power.png (placeholder - no image exists)
# 3. Green Plant Kit currently has page9 (Aspire) -> revert to images/carbo-power.png (placeholder)
# 4. Zoyo currently has page12 (Comet) -> revert to images/carbo-power.png (placeholder)
# 5. Tomo currently has page13 (Delta Super) -> revert to images/carbo-power.png (placeholder)
# 6. Aspire (no photo) -> should get page9
# 7. Stiny (no photo) -> should get page10
# 8. Batman (no photo) -> should get page11
# 9. Comet (no photo) -> should get page12
# 10. Delta Super has page23 (Delta Power) -> should get page13

$fixes = @{
    # Products that had wrong photos - revert (no specific photo exists for these PGR products)
    'Carbo Power' = 'images/carbo-power.png'
    'Growset' = 'images/growset.png'
    'Green Plant Kit' = 'images/green-plant-kit.png'
    'Zoyo' = 'images/zoyo.png'
    'Tomo' = 'images/tomo.png'
    # Products that should get the corrected photos
    'Aspire' = 'photos/page9_img0_41.jpeg'
    'Stiny' = 'photos/page10_img0_44.jpeg'
    'Batman' = 'photos/page11_img0_47.jpeg'
    'Comet' = 'photos/page12_img0_50.jpeg'
    'Delta Super' = 'photos/page13_img0_53.jpeg'
}

$regex = [regex]'(?s)(data-category="([^"]*)"[^>]*data-name="([^"]*)"[^>]*>.*?<img\s+src=")([^"]*)(")'

$content = $regex.Replace($content, {
    param($m)
    $category = $m.Groups[2].Value
    $productName = $m.Groups[3].Value
    $currentSrc = $m.Groups[4].Value
    
    if ($fixes.ContainsKey($productName)) {
        $newSrc = $fixes[$productName]
        Write-Host "Fixed: $productName ($category) : $currentSrc -> $newSrc"
        return "$($m.Groups[1].Value)$newSrc$($m.Groups[5].Value)"
    }
    
    return $m.Value
})

[System.IO.File]::WriteAllText($htmlFile, $content)
Write-Host "`nDone! Fixed 10 product image mappings."
