
# --- Sozlamalar
$csvFolder     = "C:\Users\Admin\Desktop\Project\CSVs"
$archiveFolder = "C:\Users\Admin\Desktop\Project\CSVs\archive"
$logFile       = "C:\Users\Admin\Desktop\Project\CSVs\load_log.txt"

$serverName    = "DESKTOP-UBG68M5"
$databaseName  = "Bike_Store_Project"              
# --------------------------------------------------------------

# Fayl nomi -> staging jadval mapping (9 ta jadval misoli)
$mappings = @{
  "orders.csv"       = "staging.orders"
  "order_items.csv"  = "staging.order_items"
  "customers.csv"    = "staging.customers"
  "products.csv"     = "staging.products"
  "stocks.csv"       = "staging.stocks"
  "staffs.csv"       = "staging.staffs"
  "stores.csv"       = "staging.stores"
  "brands.csv"       = "staging.brands"
  "categories.csv"   = "staging.categories"
}

# Agar SqlServer moduli yo'q bo'lsa, o'rnatishga harakat qiladi (bir marta kifoya)
try { Import-Module SqlServer -ErrorAction Stop }
catch { Install-Module -Name SqlServer -Scope CurrentUser -Force; Import-Module SqlServer }

# Papkalar bor-yo'qligini tekshirish
if (!(Test-Path $csvFolder))     { throw "CSV papkasi topilmadi: $csvFolder" }
if (!(Test-Path $archiveFolder)) { New-Item -ItemType Directory -Path $archiveFolder | Out-Null }

$ErrorActionPreference = 'Stop'
Add-Content -Path $logFile -Value "==== $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') — Yuklash boshlandi ===="

# Papkadagi barcha .csv fayllar
$files = Get-ChildItem -Path $csvFolder -Filter *.csv -File

foreach ($file in $files) {
    try {
        $name = $file.Name.ToLower()
        if (-not $mappings.ContainsKey($name)) {
            Add-Content $logFile "SKIP: Mapping yo'q → $name"
            continue
        }

        $tableName = $mappings[$name]
        $fullPath  = $file.FullName

        Write-Host    "Yuklanmoqda: $fullPath → $tableName"
        Add-Content   $logFile "LOAD: $fullPath → $tableName"

        # BULK INSERT opsiyalari: UTF-8, 1-qatorda header, vergul ajratgich
        $bulkQuery = @"
BULK INSERT $tableName
FROM '$fullPath'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001',
    KEEPNULLS,
    TABLOCK
);
"@

        Invoke-Sqlcmd -ServerInstance $serverName -Database $databaseName -Query $bulkQuery

        # Muvaffaqiyatli bo'lsa, faylni arxivga ko'chiramiz (nomiga timestamp qo'shib)
        $stamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $dest  = Join-Path $archiveFolder ($file.BaseName + "_" + $stamp + $file.Extension)
        Move-Item -Path $fullPath -Destination $dest

        Add-Content $logFile "OK  : $name → $tableName (moved to $dest)"
    }
    catch {
        $msg = $_.Exception.Message
        Write-Warning "Xato: $name → $msg"
        Add-Content $logFile "ERR : $name → $msg"
        # xohlasangiz, xatoda ham keyingi faylga o'tishda davom etamiz
        continue
    }
}

Add-Content -Path $logFile -Value "==== $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') — Yuklash tugadi ===="
Write-Host "Barcha CSV fayllar yuklandi (yoki log faylini tekshiring)."
