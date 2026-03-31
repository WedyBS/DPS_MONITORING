; Fungsi klik ganda
ClickAt(x, y) {
    CoordMode("Mouse", "Screen")  ; gunakan koordinat layar
    MouseMove(x, y)
    Click(2)  ; double click kiri
}

; Tunggu beberapa detik agar program siap (misal 1,5 detik)
Sleep(1500)

; Jalankan klik otomatis di koordinat 39,108
ClickAt(39, 108)
