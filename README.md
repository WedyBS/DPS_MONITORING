# 📡 MONITORING TEKNIK FASILITAS PENUNJANG
## AIRNAV Indonesia — Cabang Denpasar

> Sistem monitoring real-time berbasis **Node-RED** untuk memantau fasilitas penunjang navigasi udara di Bandara Internasional I Gusti Ngurah Rai, Denpasar, Bali.

---

## 📋 Daftar Isi

- [Panduan Instalasi Node-RED](#-panduan-instalasi-node-red)
  - [Persyaratan Sistem](#persyaratan-sistem)
  - [Install Node.js](#langkah-1--install-nodejs)
  - [Install Node-RED](#langkah-2--install-node-red)
  - [Jalankan Otomatis](#langkah-3--jalankan-node-red-otomatis-saat-pc-nyala)
  - [Install Plugin](#langkah-4--install-plugin-yang-dibutuhkan)
  - [Import Flow](#langkah-5--import-flow-monitoring)
  - [Konfigurasi](#langkah-6--sesuaikan-konfigurasi)
  - [Akses Dashboard](#langkah-7--akses-dashboard)
- [Daftar Flow](#-daftar-flow)
- [Fitur Utama](#%EF%B8%8F-fitur-utama)
- [Halaman Dashboard](#%EF%B8%8F-halaman-dashboard)
- [Koneksi Modbus](#-koneksi-modbus)
- [Struktur File DataLogger](#-struktur-file-datalogger-csv)
- [Threshold & Parameter](#-threshold--parameter)
- [Troubleshooting](#-troubleshooting)

---

## 📦 PANDUAN INSTALASI NODE-RED

### Persyaratan Sistem

| Komponen | Minimum |
|----------|---------|
| OS | Windows 10/11, Ubuntu 20.04+, atau Raspberry Pi OS |
| RAM | 2 GB |
| Storage | 10 GB |
| Node.js | v18 atau v20 (LTS) |

---

### LANGKAH 1 — Install Node.js

#### 🪟 Windows

1. Buka browser, kunjungi [https://nodejs.org](https://nodejs.org)
2. Download versi **LTS** (misal: 20.x.x LTS)
3. Jalankan installer `.msi`, klik Next sampai selesai
4. Buka **Command Prompt**, verifikasi instalasi:

```bash
node --version
npm --version
```

> ✅ Jika muncul versi, berarti Node.js berhasil terinstall.

#### 🐧 Ubuntu / Linux

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
node --version
npm --version
```

#### 🍓 Raspberry Pi

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
```

---

### LANGKAH 2 — Install Node-RED

Buka **Command Prompt** (Windows) atau **Terminal** (Linux/Mac), lalu jalankan:

```bash
npm install -g --unsafe-perm node-red
```

Setelah selesai, jalankan Node-RED:

```bash
node-red
```

Buka browser dan akses:

```
http://localhost:1880
```

> ✅ Jika muncul tampilan editor Node-RED, instalasi berhasil.

---

### LANGKAH 3 — Jalankan Node-RED Otomatis saat PC Nyala

#### 🪟 Windows — Menggunakan PM2

```bash
npm install -g pm2
pm2 start node-red
pm2 startup
pm2 save
```

#### 🐧 Linux / Ubuntu

```bash
npm install -g pm2
pm2 start node-red
pm2 startup systemd
pm2 save
```

#### 🍓 Raspberry Pi (systemd)

```bash
sudo systemctl enable nodered.service
sudo systemctl start nodered.service
```

---

### LANGKAH 4 — Install Plugin yang Dibutuhkan

Buka Node-RED editor di browser:

```
http://localhost:1880
```

Klik menu **≡ (hamburger) → Manage Palette → Install**, lalu cari dan install satu per satu:

| Plugin | Fungsi |
|--------|--------|
| `@flowfuse/node-red-dashboard` | Dashboard UI tampilan web |
| `node-red-contrib-modbus` | Komunikasi Modbus TCP/RTU |
| `node-red-contrib-telegrambot` | Notifikasi via Telegram |
| `node-red-node-ping` | Cek konektivitas jaringan |
| `node-red-contrib-simpletime` | Format tanggal & waktu |
| `node-red-contrib-bacnet` | Komunikasi BACnet (Localizer & GP) |

#### ⚡ Atau Install Sekaligus via Terminal (lebih cepat)

Masuk ke folder Node-RED:

```bash
# Windows
cd C:\Users\<NamaUser>\.node-red

# Linux / Raspberry Pi
cd ~/.node-red
```

Jalankan perintah berikut:

```bash
npm install @flowfuse/node-red-dashboard
npm install node-red-contrib-modbus
npm install node-red-contrib-telegrambot
npm install node-red-node-ping
npm install node-red-contrib-simpletime
npm install node-red-contrib-bacnet
```

Setelah selesai, **restart Node-RED**:

```bash
# Jika pakai PM2
pm2 restart node-red

# Jika jalan manual — tekan Ctrl+C lalu jalankan ulang
node-red
```

---

### LANGKAH 5 — Import Flow Monitoring

1. Buka browser → `http://localhost:1880`
2. Klik menu **≡ → Import**
3. Klik **"select a file to import"**
4. Pilih file flows.json dari repo ini
5. Klik **Import**
6. Klik tombol **Deploy** (tombol merah kanan atas)

> ⚠️ Pastikan IP address perangkat Modbus sudah sesuai dengan jaringan lokal Anda sebelum klik Deploy.

---

### LANGKAH 6 — Sesuaikan Konfigurasi

#### 🔌 Ganti IP Address Modbus

Klik dua kali pada node **modbus-read** atau **modbus-getter**, lalu edit IP di bagian **Server**.

Daftar IP default sistem ini:

| Perangkat | IP Default | Port | Protokol |
|-----------|-----------|------|----------|
| GEDUNG TX | 172.19.7.142 | 502 | TCP-RTU-BUFFERED |
| SERVER 1 | 172.19.7.148 | 502 | TCP-RTU-BUFFERED |
| SERVER 2 | 172.19.7.147 | 502 | TCP-RTU-BUFFERED |
| CNS 3 | 172.19.7.144 | 502 | TCP-RTU-BUFFERED |
| CNS 4 | 172.19.7.143 | 502 | TCP-RTU-BUFFERED |
| KINTAMANI | 172.19.7.146 | 502 | TCP-RTU-BUFFERED |
| DVOR | 172.19.7.160 | 26 | TELNET |
| RADAR | 172.19.7.159 | 26 | TELNET |
| LOCALIZER | 172.19.7.145 | 502 | TCP-RTU-BUFFERED |
| LLZ | 172.19.7.130 | 26 | TELNET |
| GLIDE PATH | 172.19.7.129 | 26 | TELNET |
| DSE Genset | 172.19.7.188 | 502 | TCP |
| AC BG | 172.19.7.239 | 502 | TELNET |

#### 📁 Ganti Path Penyimpanan CSV (Windows)

Cari node **file** dengan nama *"Simpan DataLogger"*, ubah path sesuai komputer Anda:

```
C:\Users\<NamaUser>\Desktop\DataLoggersListrikDPS\
```

Buat folder tersebut terlebih dahulu jika belum ada:

```bash
mkdir "C:\Users\<NamaUser>\Desktop\DataLoggersListrikDPS"
```

#### 📲 Ganti Token Telegram Bot (Opsional)

Jika ingin menggunakan bot Telegram sendiri:

1. Chat [@BotFather](https://t.me/BotFather) di Telegram
2. Ketik `/newbot` dan ikuti instruksi
3. Copy token yang diberikan
4. Di Node-RED, klik node **telegram sender** → Edit Bot → masukkan token baru
5. Ganti `chatId` di function node dengan Chat ID grup/personal Anda

> 💡 Untuk cek Chat ID Anda, forward pesan ke [@userinfobot](https://t.me/userinfobot)

---

### LANGKAH 7 — Akses Dashboard

Setelah Deploy berhasil, buka browser dan akses:

```
http://localhost:1880/dashboard
```

Atau dari perangkat lain dalam jaringan yang sama:

```
http://<IP-Komputer-Server>:1880/dashboard
```

---

## 🗂️ Daftar Flow

| Flow | Deskripsi |
|------|-----------|
| `TX DAN DVOR` | Monitoring  Catu Daya, suhu, dan kelembapan Transmitter & DVOR |
| `SERVER 1 DAN 2` | Monitoring Catu Daya, suhu, dan kelembapan  ATC System 1 & 2 |
| `CNS 3 DAN 4` | Monitoring  Catu Daya , suhu, dan kelembapan  CNS & A Unit 3 & 4 |
| `RADAR DAN KINTAMANI` | Monitoring Catu Daya , suhu, dan kelembapan  Radar & Repeater Kintamani |
| `TOWER` | Monitoring Catu Daya , suhu, dan kelembapan  Tower ATC |
| `LOCALIZER dan GP` | Monitoring Catu Daya , suhu, dan kelembapan Localizer & Glide Path (ILS) |
| `DATALOGGER` | Download CSV alarm history per fasilitas |
| `SOP` | Akses SOP & Manual Book via dashboard |
| `GENSET` | Monitoring Genset Perkins 250 KVA |
| `AC` | Monitoring & kontrol AC VRF DVOR |
| `System Monitor` | Panel health server (CPU, RAM, disk, network) |
| `GWT MONITORING` | Monitoring Ground Water Tank via Tuya IoT API |

---

## ⚙️ Fitur Utama

### 🔌 Monitoring Tegangan & Daya
- Baca register Modbus dari UPS PM 5350 dan 5320 (tegangan, daya, frekuensi)
- Menampilkan status NORMAL/GANGGUAN, daya dalam Watt/kW
- Gauge, chart real-time, dan rata-rata tegangan harian (AVG)

### 🌡️ Sensor Suhu & Kelembapan
- Baca sensor suhu & RH dari Modbus (RTU over TCP/Telnet)
- Alert audio otomatis jika suhu > 25°C
- Tampil di dashboard dengan status NORMAL/WARNING berkedip

### 📡 Ping & Network Monitoring
- Ping ke setiap perangkat setiap 5 detik
- LED indikator hijau (online) / merah (offline) per perangkat
- Anti-spam: notifikasi "NETWORK DOWN" baru dikirim setelah 3x gagal berturut-turut

### 📲 Notifikasi Telegram
- Bot: `ListrikKhayangan_bot`
- Kirim pesan otomatis saat status listrik berubah ON/OFF
- Format pesan: nama fasilitas, hari, tanggal, dan status terkini

### 📊 Datalogger CSV
- Simpan data timestamp, suhu, dan tegangan ke file `.csv` per fasilitas
- Endpoint HTTP GET untuk download langsung dari dashboard

### 🔋 Monitoring Genset (DeepSea 8610 MKII)
- Status operasi: AUTO / MANUAL / STOP
- Monitoring tegangan baterai, RPM, frekuensi, daya output
- Hitung jam operasi kumulatif (run hours) dengan jam awal custom
- Gauge fuel level & grafik tegangan real-time

### 💧 Ground Water Tank (Tuya IoT)
- Integrasi Tuya OpenAPI dengan token refresh otomatis tiap 1 jam
- Tampil level air dalam persen & estimasi volume (liter)
- Visual animasi tangki vertikal dengan efek gelombang
- Alarm otomatis jika level ≤ 20% (rendah) atau ≥ 90% (tinggi)
- Notifikasi pop-up di dashboard

### ❄️ Kontrol AC Split DVOR
- Baca arus AC1 & AC2 dari Modbus
- Tombol ON/OFF relay dilindungi password
- Tampil status AC (ON/OFF) dengan gambar dinamis

---

## 🖥️ Halaman Dashboard

| Halaman | Path | Isi |
|---------|------|-----|
| Fasilitas Penunjang 2.0 | `/SUPPORT` | Overview semua fasilitas (TX, DVOR, Radar, dll.) |
| Fasilitas Penunjang | `/main` | Panel individu per fasilitas |
| Operation Building & Tower | `/building` | Monitoring gedung & tower |
| Shelter Denpasar | `/shelter` | Monitoring shelter fasilitas |
| Pemakaian Daya (KWH) | `/KWH` | Grafik bar pemakaian KWH per bulan |
| AC AIRNAV Denpasar | `/AC` | Kontrol & monitoring AC |
| SOP & Manual Book | `/page4` | Akses dokumen SOP & manual |

---

## 📁 Struktur File DataLogger (CSV)

```
C:\Users\USER\Desktop\DataLoggersListrikDPS\
├── TXDataLoggers.csv
├── DVORDataLoggers.csv
├── app1DataLoggers.csv         ← ATC System 1
├── app2DataLoggers.csv         ← ATC System 2
├── CNS3DataLoggers.csv
├── CNS4DataLoggers.csv
├── RadarDataLoggers.csv
├── KintamaniDataLoggers.csv
├── TwrDataLoggers.csv
├── LLZDataLoggers.csv
└── GPDataLoggers.csv
```

---

## 📌 Threshold & Parameter

| Parameter | Nilai Normal |
|-----------|-------------|
| Tegangan listrik | 198V – 242V |
| Suhu ruangan | 16°C – 25°C |
| Kelembapan | 35% – 75% |
| Level GWT rendah (alarm) | ≤ 20% |
| Level GWT tinggi (info) | ≥ 90% |
| Kapasitas tangki GWT | 17.000 Liter |

---

## 🔧 Troubleshooting

| Masalah | Solusi |
|---------|--------|
| Dashboard tidak muncul | Pastikan plugin `@flowfuse/node-red-dashboard` terinstall dan sudah Deploy |
| Data Modbus tidak terbaca | Cek IP & port, pastikan perangkat terhubung ke jaringan yang sama |
| Telegram tidak mengirim pesan | Cek token bot & Chat ID di function node |
| Node-RED tidak bisa dibuka | Cek apakah port 1880 diblokir firewall Windows/Linux |
| CSV tidak tersimpan | Pastikan folder tujuan sudah dibuat dan path sudah sesuai |
| Plugin tidak ditemukan di Palette | Coba install ulang via terminal di folder `.node-red` |
| Sensor suhu terbaca 0 atau aneh | Normal — sistem menggunakan "last good value", tunggu beberapa detik |
| GWT tidak update | Cek koneksi internet & pastikan Tuya token masih valid |

---

## 📋 Persyaratan Plugin Lengkap

```bash
npm install @flowfuse/node-red-dashboard
npm install node-red-contrib-modbus
npm install node-red-contrib-telegrambot
npm install node-red-node-ping
npm install node-red-contrib-simpletime
npm install node-red-contrib-bacnet
```

---

## 👤 Dikembangkan Oleh

**Tim Teknisi Fasilitas Penunjang**
AIRNAV Indonesia — Cabang Denpasar
Bandara I Gusti Ngurah Rai, Bali


