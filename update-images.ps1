# PowerShell script to update product images in index.html
# Maps product data-name to photo files from the photos/ directory

$htmlFile = "d:\GB\GB2-main\index.html"
$content = Get-Content $htmlFile -Raw -Encoding UTF8

# Product-to-photo mapping (data-name -> photo filename)
$mapping = @{
    # PGR
    'All In One' = 'photos/page3_img0_20.jpeg'
    'Altar' = 'photos/page4_img0_23.jpeg'
    'Green Power 95' = 'photos/page5_img0_26.jpeg'
    'Root Care' = 'photos/page6_img0_29.jpeg'
    'Sticking' = 'photos/page7_img0_32.jpeg'
    'Green Plant Kit' = 'photos/page9_img0_41.jpeg'
    'Carbo Power' = 'photos/page10_img0_44.jpeg'
    'Growset' = 'photos/page11_img0_47.jpeg'
    'Zoyo' = 'photos/page12_img0_50.jpeg'
    'Tomo' = 'photos/page13_img0_53.jpeg'
    # Insecticide
    'Corsa+' = 'photos/page14_img0_56.jpeg'
    'Chlor20' = 'photos/page15_img0_59.jpeg'
    'Ethop' = 'photos/page16_img0_62.jpeg'
    'Deltraa' = 'photos/page17_img0_65.jpeg'
    'G-Nova' = 'photos/page18_img0_68.jpeg'
    'Final Call' = 'photos/page19_img0_71.jpeg'
    'Chloroseal' = 'photos/page20_img0_74.jpeg'
    'Corando Lambda' = 'photos/page21_img0_77.jpeg'
    'Green-Minda' = 'photos/page22_img0_80.jpeg'
    'Delta Power' = 'photos/page23_img0_83.jpeg'
    'Jumbo+' = 'photos/page24_img0_86.jpeg'
    'Imidon 70' = 'photos/page25_img0_89.jpeg'
    'Mono 69' = 'photos/page26_img0_92.jpeg'
    'SuperLambda' = 'photos/page27_img0_95.jpeg'
    'Super-Mida' = 'photos/page28_img0_98.jpeg'
    'Korsa Super' = 'photos/page29_img0_101.jpeg'
    'Rudrax' = 'photos/page30_img0_104.jpeg'
    'Rescue' = 'photos/page31_img0_107.jpeg'
    'Rocket' = 'photos/page32_img0_110.jpeg'
    'Corrazone' = 'photos/page33_img0_113.jpeg'
    '10-Cyper' = 'photos/page34_img0_116.jpeg'
    'Agrofen' = 'photos/page35_img0_119.jpeg'
    'Cypro Green' = 'photos/page36_img0_122.jpeg'
    'Deltos' = 'photos/page37_img0_125.jpeg'
    'Eco Kill' = 'photos/page38_img0_128.jpeg'
    'Indo Far' = 'photos/page39_img0_131.jpeg'
    'Indoxa-G' = 'photos/page40_img0_134.jpeg'
    'Jack' = 'photos/page41_img0_137.jpeg'
    'Jill' = 'photos/page42_img0_140.jpeg'
    'King' = 'photos/page43_img0_143.jpeg'
    'Vangor' = 'photos/page44_img0_146.jpeg'
    'Neemastra' = 'photos/page45_img0_149.jpeg'
    'Paris' = 'photos/page46_img0_152.jpeg'
    'Pollen' = 'photos/page47_img0_155.jpeg'
    'Typhoon' = 'photos/page48_img0_158.jpeg'
    'Profen Super 404' = 'photos/page49_img0_161.jpeg'
    'Progold 50' = 'photos/page50_img0_164.jpeg'
    'Rion' = 'photos/page51_img0_167.jpeg'
    'Thawino' = 'photos/page52_img0_170.jpeg'
    'Hitmax' = 'photos/page53_img0_173.jpeg'
    'U-Tera' = 'photos/page54_img0_176.jpeg'
    'Tapus' = 'photos/page55_img0_179.jpeg'
    'Startine' = 'photos/page56_img0_182.jpeg'
    'Lesar Scode' = 'photos/page57_img0_185.jpeg'
    'Urrja' = 'photos/page58_img0_188.jpeg'
    'Legend' = 'photos/page59_img0_191.jpeg'
    'Polar' = 'photos/page60_img0_194.jpeg'
    'Speed' = 'photos/page61_img0_197.jpeg'
    'Elexa' = 'photos/page62_img0_200.jpeg'
    'Yodha' = 'photos/page63_img0_203.jpeg'
    'A-Tara' = 'photos/page64_img0_206.jpeg'
    'Aveator' = 'photos/page65_img0_209.jpeg'
    'Delta Super' = 'photos/page23_img0_83.jpeg'
    'Cypro No-1' = 'photos/page88_img0_282.jpeg'
    'Cypro Power' = 'photos/page89_img0_285.jpeg'
    # Fungicide
    'Azoteb Extra' = 'photos/page67_img0_219.jpeg'
    'zoteb Extra' = 'photos/page67_img0_219.jpeg'
    'Azoxy Super' = 'photos/page68_img0_222.jpeg'
    'Bonus' = 'photos/page69_img0_225.jpeg'
    'Super Confab' = 'photos/page70_img0_228.jpeg'
    'Twin Star' = 'photos/page71_img0_231.jpeg'
    'Tengo' = 'photos/page72_img0_234.jpeg'
    'Confab Plus+' = 'photos/page73_img0_237.jpeg'
    'Folyor' = 'photos/page74_img0_240.jpeg'
    'Valure' = 'photos/page75_img0_243.jpeg'
    'Coro Nill' = 'photos/page76_img0_246.jpeg'
    'Sulfar-55' = 'photos/page77_img0_249.jpeg'
    'sulfer55%' = 'photos/page77_img0_249.jpeg'
    'Power Stine' = 'photos/page78_img0_252.jpeg'
    'Savaj' = 'photos/page79_img0_255.jpeg'
    'Booster' = 'photos/page80_img0_258.jpeg'
    'Manacozzb' = 'photos/page82_img0_264.jpeg'
    'Safar' = 'photos/page83_img0_267.jpeg'
    'Sulffer 90' = 'photos/page84_img0_270.jpeg'
    'Unistin' = 'photos/page85_img0_273.jpeg'
    'Sulfa Gold' = 'photos/page86_img0_276.jpeg'
    'Super Jatayu' = 'photos/page87_img0_279.jpeg'
    'Trigar' = 'photos/page90_img0_288.jpeg'
    'Swaraj' = 'photos/page91_img0_291.jpeg'
    # Herbicide
    'Pendo Super' = 'photos/page93_img0_298.jpeg'
    'Sunami' = 'photos/page94_img0_301.jpeg'
    '2,4-D Ethyl Ora' = 'photos/page95_img0_304.jpeg'
    'Safayo' = 'photos/page96_img0_307.jpeg'
    'Rider' = 'photos/page97_img0_310.jpeg'
    'Pendi Green' = 'photos/page98_img0_313.jpeg'
    'Pendi Power' = 'photos/page99_img0_316.jpeg'
    'Round Plus' = 'photos/page102_img0_325.jpeg'
    'Seff Gard' = 'photos/page103_img0_328.jpeg'
    'Super Turbo' = 'photos/page104_img0_331.jpeg'
    'Oxyareen' = 'photos/page105_img0_334.jpeg'
    'King Weed' = 'photos/page106_img0_337.jpeg'
    'Tera Super' = 'photos/page107_img0_340.jpeg'
    'Xyls' = 'photos/page108_img0_343.jpeg'
    'All Grip' = 'photos/page109_img0_346.jpeg'
    'Imaza Gold' = 'photos/page110_img0_349.jpeg'
    'Amaza Super' = 'photos/page111_img0_352.jpeg'
    'Atrazen' = 'photos/page112_img0_355.jpeg'
    'Green 71' = 'photos/page113_img0_358.jpeg'
    'Greenfy41' = 'photos/page101_img0_322.jpeg'
}

# Special cases: "Extra" appears in both Fungicide and Herbicide
# Fungicide Extra = page81 (Hexaconazole 75% WG)
# Herbicide Extra = page100 (2,4-D amine salt 58% SL)

$updatedCount = 0
$skippedCount = 0
$notFoundProducts = @()

# Find all product cards and update their image src
$regex = [regex]'(?s)(data-category="([^"]*)"[^>]*data-name="([^"]*)"[^>]*>.*?<img\s+src=")([^"]*)(")'

$content = $regex.Replace($content, {
    param($m)
    $category = $m.Groups[2].Value
    $productName = $m.Groups[3].Value
    $currentSrc = $m.Groups[4].Value
    
    $newSrc = $null
    
    # Handle "Extra" appearing in both categories
    if ($productName -eq "Extra" -and $category -eq "Fungicide") {
        $newSrc = "photos/page81_img0_261.jpeg"
    } elseif ($productName -eq "Extra" -and $category -eq "Herbicide") {
        $newSrc = "photos/page100_img0_319.jpeg"
    } elseif ($mapping.ContainsKey($productName)) {
        $newSrc = $mapping[$productName]
    }
    
    if ($newSrc) {
        $script:updatedCount++
        Write-Host "Updated: $productName ($category) -> $newSrc"
        return "$($m.Groups[1].Value)$newSrc$($m.Groups[5].Value)"
    } else {
        $script:skippedCount++
        $script:notFoundProducts += "$productName ($category)"
        Write-Host "Skipped: $productName ($category) - no photo mapping"
        return $m.Value
    }
})

# Write the updated file
[System.IO.File]::WriteAllText($htmlFile, $content)

Write-Host "`n--- Summary ---"
Write-Host "Updated: $updatedCount products"
Write-Host "Skipped: $skippedCount products"
if ($notFoundProducts.Count -gt 0) {
    Write-Host "`nProducts without photo mapping:"
    foreach ($p in $notFoundProducts) {
        Write-Host "  - $p"
    }
}
