@echo off
cd /d "C:\Program Files (x86)\MOPIENS\PMDT"

:: Jalankan RegistryLib.exe
:: start "" "RegistryLib.exe"

:: Tunggu 2 detik
timeout /t 2 >nul

:: Jalankan PMDT.exe dengan maximized
start "" /MAX "PMDT.exe"

:: Tunggu 3 detik supaya PMDT terbuka
timeout /t 3 >nul

:: Jalankan skrip AutoHotkey untuk klik otomatis
start "" "C:\Users\USER\.node-red\Skrip\tes.ahk"

exit
