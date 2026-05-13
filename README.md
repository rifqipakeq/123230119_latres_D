# latihan_responsi

Deskripsi
- Aplikasi demo toko online yang menampilkan produk, detail produk, keranjang belanja, dan otentikasi pengguna sederhana.
- Menyimpan data keranjang menggunakan Hive dan menampilkan notifikasi lokal.

Fitur utama
- Daftar produk dan detail produk
- Penambahan / pengurangan item di keranjang
- Penyimpanan keranjang per-user (isolasi akun) menggunakan Hive
- Notifikasi lokal 

Struktur proyek (folder penting di `lib/`)
- `controllers/` : logika state dan kontrol alur 
- `models/` : model data aplikasi dan adapter Hive
- `services/` : layanan seperti panggilan API, penyimpanan lokal, dan notifikasi
- `routes/` : definisi rute aplikasi
- `utils/`, `views/`, `widgets/` : utilitas, tampilan, dan komponen UI

Persistensi
- Hive digunakan untuk menyimpan data lokal.

Dependensi utama:
- `get` : manajemen state dan navigasi
- `http` : komunikasi jaringan
- `hive`, `hive_flutter` : penyimpanan lokal berbasis box
- `shared_preferences` : penyimpanan preferensi kecil
- `flutter_local_notifications` : notifikasi lokal

Menjalankan proyek
1. Install dependency:

```bash
flutter pub get
```

2. Generate kode Hive adapter:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3. Jalankan aplikasi:

```bash
flutter run
```