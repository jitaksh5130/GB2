const fs = require('fs');
const path = require('path');

// Complete product-to-photo mapping based on visual inspection of all photos
// Format: "data-name value (case-sensitive from HTML)" -> "photo filename"
const productPhotoMap = {
  // PGR Category
  "All In One": "page3_img0_20.jpeg",
  "Altar": "page4_img0_23.jpeg",
  "Green Power 95": "page5_img0_26.jpeg",
  "Root Care": "page6_img0_29.jpeg",
  "Sticking": "page7_img0_32.jpeg",
  "Green Plant Kit": "page9_img0_41.jpeg",
  "Carbo Power": "page10_img0_44.jpeg",
  "Growset": "page11_img0_47.jpeg",
  "Zoyo": "page12_img0_50.jpeg",
  "Tomo": "page13_img0_53.jpeg",
  
  // Insecticide Category
  "Corsa+": "page14_img0_56.jpeg",
  "Chlor20": "page15_img0_59.jpeg",
  "Ethop": "page16_img0_62.jpeg",
  "Deltraa": "page17_img0_65.jpeg",
  "G-Nova": "page18_img0_68.jpeg",
  "Final Call": "page19_img0_71.jpeg",
  "Chloroseal": "page20_img0_74.jpeg",
  "Corando Lambda": "page21_img0_77.jpeg",
  "Green-Minda": "page22_img0_80.jpeg",
  "Delta Power": "page23_img0_83.jpeg",
  "Jumbo+": "page24_img0_86.jpeg",
  "Imidon 70": "page25_img0_89.jpeg",
  "Mono 69": "page26_img0_92.jpeg",
  "SuperLambda": "page27_img0_95.jpeg",
  "Super-Mida": "page28_img0_98.jpeg",
  "Korsa Super": "page29_img0_101.jpeg",
  "Rudrax": "page30_img0_104.jpeg",
  "Rescue": "page31_img0_107.jpeg",
  "Rocket": "page32_img0_110.jpeg",
  "Corrazone": "page33_img0_113.jpeg",
  "10-Cyper": "page34_img0_116.jpeg",
  "Agrofen": "page35_img0_119.jpeg",
  "Cypro Green": "page36_img0_122.jpeg",
  "Deltos": "page37_img0_125.jpeg",
  "Eco Kill": "page38_img0_128.jpeg",
  "Indo Far": "page39_img0_131.jpeg",
  "Indoxa-G": "page40_img0_134.jpeg",
  "Jack": "page41_img0_137.jpeg",
  "Jill": "page42_img0_140.jpeg",
  "King": "page43_img0_143.jpeg",
  "Vangor": "page44_img0_146.jpeg",
  "Neemastra": "page45_img0_149.jpeg",
  "Paris": "page46_img0_152.jpeg",
  "Pollen": "page47_img0_155.jpeg",
  "Typhoon": "page48_img0_158.jpeg",
  "Profen Super 404": "page49_img0_161.jpeg",
  "Progold 50": "page50_img0_164.jpeg",
  "Rion": "page51_img0_167.jpeg",
  "Thawino": "page52_img0_170.jpeg",
  "Hitmax": "page53_img0_173.jpeg",
  "U-Tera": "page54_img0_176.jpeg",
  "Tapus": "page55_img0_179.jpeg",
  "Startine": "page56_img0_182.jpeg",
  "Lesar Scode": "page57_img0_185.jpeg",
  "Urrja": "page58_img0_188.jpeg",
  "Legend": "page59_img0_191.jpeg",
  "Polar": "page60_img0_194.jpeg",
  "Speed": "page61_img0_197.jpeg",
  "Elexa": "page62_img0_200.jpeg",
  "Yodha": "page63_img0_203.jpeg",
  "A-Tara": "page64_img0_206.jpeg",
  "Aveator": "page65_img0_209.jpeg",
  "Delta Super": "page23_img0_83.jpeg", // Uses same image as Delta Power (similar product)
  "Cypro No-1": "page88_img0_282.jpeg",
  "Cypro Power": "page89_img0_285.jpeg",
  
  // Fungicide Category  
  "Azoteb Extra": "page67_img0_219.jpeg",
  "zoteb Extra": "page67_img0_219.jpeg", // Same product, different name in HTML
  "Azoxy Super": "page68_img0_222.jpeg",
  "Bonus": "page69_img0_225.jpeg",
  "Super Confab": "page70_img0_228.jpeg",
  "Twin Star": "page71_img0_231.jpeg",
  "Tengo": "page72_img0_234.jpeg",
  "Confab Plus+": "page73_img0_237.jpeg",
  "Folyor": "page74_img0_240.jpeg",
  "Valure": "page75_img0_243.jpeg",
  "Coro Nill": "page76_img0_246.jpeg",
  "Sulfar-55": "page77_img0_249.jpeg",
  "sulfer55%": "page77_img0_249.jpeg", // Same product, different name
  "Power Stine": "page78_img0_252.jpeg",
  "Savaj": "page79_img0_255.jpeg",
  "Booster": "page80_img0_258.jpeg",
  "Extra": "page81_img0_261.jpeg", // Fungicide Extra (Hexaconazole)  
  "Manacozzb": "page82_img0_264.jpeg",
  "Safar": "page83_img0_267.jpeg",
  "Sulffer 90": "page84_img0_270.jpeg",
  "Unistin": "page85_img0_273.jpeg",
  "Sulfa Gold": "page86_img0_276.jpeg",
  "Super Jatayu": "page87_img0_279.jpeg",
  "Trigar": "page90_img0_288.jpeg",
  "Swaraj": "page91_img0_291.jpeg",
  
  // Herbicide Category
  "Pendo Super": "page93_img0_298.jpeg",
  "Sunami": "page94_img0_301.jpeg",
  "2,4-D Ethyl Ora": "page95_img0_304.jpeg",
  "Safayo": "page96_img0_307.jpeg",
  "Rider": "page97_img0_310.jpeg",
  "Pendi Green": "page98_img0_313.jpeg",
  "Pendi Power": "page99_img0_316.jpeg",
  "Round Plus": "page102_img0_325.jpeg",
  "Seff Gard": "page103_img0_328.jpeg",
  "Super Turbo": "page104_img0_331.jpeg",
  "Oxyareen": "page105_img0_334.jpeg",
  "King Weed": "page106_img0_337.jpeg",
  "Tera Super": "page107_img0_340.jpeg", // Tark Super -> Tera Super
  "Xyls": "page108_img0_343.jpeg",
  "All Grip": "page109_img0_346.jpeg",
  "Imaza Gold": "page110_img0_349.jpeg",
  "Amaza Super": "page111_img0_352.jpeg",
  "Atrazen": "page112_img0_355.jpeg",
  "Green 71": "page113_img0_358.jpeg",
  "Greenfy41": "page101_img0_322.jpeg",
};

// Products that have "Extra" in both Fungicide and Herbicide categories
// The Herbicide "Extra" (2,4-D amine salt) corresponds to page100
const herbicideExtra = "page100_img0_319.jpeg";

const htmlFile = path.join(__dirname, 'index.html');
let html = fs.readFileSync(htmlFile, 'utf-8');

let updatedCount = 0;
let skippedCount = 0;
let notFoundProducts = [];

// Process the HTML to find each product card and update its image
// We use regex to find product cards with their data-name and img src
const cardRegex = /(<div\s+class="product-card"[^>]*data-category="([^"]*)"[^>]*data-name="([^"]*)"[^>]*>[\s\S]*?<img\s+src=")([^"]*)("[^>]*class="product-card-img")/g;

let match;
let newHtml = html;

// Track replacements to handle properly
const replacements = [];

while ((match = cardRegex.exec(html)) !== null) {
  const fullMatch = match[0];
  const prefix = match[1];
  const category = match[2];
  const productName = match[3];
  const currentSrc = match[4];
  const suffix = match[5];
  
  let newSrc = null;
  
  // Special handling for "Extra" which exists in both Fungicide and Herbicide
  if (productName === "Extra" && category === "Herbicide") {
    newSrc = "photos/" + herbicideExtra;
  } else if (productPhotoMap[productName]) {
    newSrc = "photos/" + productPhotoMap[productName];
  }
  
  if (newSrc && newSrc !== currentSrc) {
    replacements.push({
      oldSrc: currentSrc,
      newSrc: newSrc,
      productName: productName,
      category: category,
      fullMatch: fullMatch
    });
    updatedCount++;
  } else if (!newSrc) {
    notFoundProducts.push(`${productName} (${category})`);
    skippedCount++;
  }
}

// Apply replacements - we go in reverse order to maintain string positions
for (const rep of replacements) {
  const oldImgTag = `src="${rep.oldSrc}"`;
  const newImgTag = `src="${rep.newSrc}"`;
  
  // Find the specific product card context to make targeted replacement
  const cardPattern = new RegExp(
    `(data-name="${rep.productName.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}"[\\s\\S]*?data-category="${rep.category}"[\\s\\S]*?<img\\s+src=")${rep.oldSrc.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}(")`
  );
  
  // Alternative: try with data-category first (which is how the HTML is structured)
  const cardPattern2 = new RegExp(
    `(data-category="${rep.category}"[\\s\\S]*?data-name="${rep.productName.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}"[\\s\\S]*?<img\\s+src=")${rep.oldSrc.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}(")`
  );
  
  if (cardPattern.test(newHtml)) {
    newHtml = newHtml.replace(cardPattern, `$1${rep.newSrc}$2`);
    console.log(`✅ Updated: ${rep.productName} (${rep.category}) -> ${rep.newSrc}`);
  } else if (cardPattern2.test(newHtml)) {
    newHtml = newHtml.replace(cardPattern2, `$1${rep.newSrc}$2`);
    console.log(`✅ Updated: ${rep.productName} (${rep.category}) -> ${rep.newSrc}`);
  } else {
    console.log(`⚠️  Pattern not matched for: ${rep.productName} (${rep.category})`);
  }
}

// Write the updated HTML
fs.writeFileSync(htmlFile, newHtml, 'utf-8');

console.log(`\n--- Summary ---`);
console.log(`Updated: ${updatedCount} products`);
console.log(`Skipped (no photo): ${skippedCount} products`);
if (notFoundProducts.length > 0) {
  console.log(`\nProducts without photo mapping:`);
  notFoundProducts.forEach(p => console.log(`  - ${p}`));
}
