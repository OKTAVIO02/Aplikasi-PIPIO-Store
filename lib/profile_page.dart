import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final String? name;
  final String? avatarAsset;

  const ProfilePage({
    Key? key,
    required this.email,
    this.name,
    this.avatarAsset = 'assets/logo.png',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Center(
        child: Card(
          color: Colors.white.withOpacity(0.93),
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            width: 340,
            height: 420, // agar ListView bisa scroll jika konten banyak
            padding: const EdgeInsets.all(28.0),
            child: ListView(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.asset(
                      avatarAsset ?? 'assets/logo.png',
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  name ?? 'Pengguna',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                ListTile(
                  leading: Icon(Icons.email, color: Colors.blue.shade700),
                  title: Text('Email'),
                  subtitle: Text(email),
                ),
                if (name != null)
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.blue.shade700),
                    title: Text('Nama'),
                    subtitle: Text(name!),
                  ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.blue.shade700),
                  title: Text('Pengaturan'),
                  subtitle: Text('Ubah pengaturan akun Anda'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.info, color: Colors.blue.shade700),
                  title: Text('Tentang Aplikasi'),
                  subtitle: Text('Versi 1.0.0'),
                  onTap: () {},
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                  label: Text('Kembali'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}