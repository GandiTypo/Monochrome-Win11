# 1. Setup UTF-8 (.NET Class - Langsung tanpa overhead variable)
[Console]::InputEncoding  = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding          = [System.Text.UTF8Encoding]::new($false)

Clear-Host

# 2. Pindah lokasi direktori
Set-Location "C:\Users\user_name\Terminal" //Replace this path with the path to your file.

# 3. Jalankan Fastfetch (Menggunakan Call Operator '&' untuk akurasi native execution)
try { & fastfetch -c "C:/Users/user_name/.config/fastfetch/config.jsonc" } catch {} //Replace this path with the path to your file.

# 4. Optimasi Oh My Posh dengan Smart Caching (.NET Speed & Auto-Update)
# 💡 TIPS: Jika kamu memakai tema Monochrome yang kita buat sebelumnya, ubah path ini ke file JSON tema barumu!
$OmpTheme = "C:\Users\user_name\AppData\Local\Programs\oh-my-posh\themes\matte-capsule-mono.omp.json" //Replace this path with the path to your file.
$OmpCache = "$env:TEMP\ohmyposh_cache.ps1"

# Menggunakan .NET Method untuk cek file (Jauh lebih cepat daripada 'Test-Path')
$RebuildCache = $true
if ([System.IO.File]::Exists($OmpCache)) {
    # Cek apakah file tema lebih baru dari file cache. Jika iya, otomatis rebuild.
    if ([System.IO.File]::GetLastWriteTime($OmpTheme) -le [System.IO.File]::GetLastWriteTime($OmpCache)) {
        $RebuildCache = $false
    }
}

if ($RebuildCache) {
    oh-my-posh init pwsh -c $OmpTheme --print | Out-File -FilePath $OmpCache -Encoding utf8
}

# Eksekusi cache instan
. $OmpCache