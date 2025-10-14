import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart'; // ✅ Tambahan

class ProfilePage extends StatefulWidget {
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
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<Map<String, String>> getDeviceInfo() async {
    try {
      final info = await deviceInfoPlugin.deviceInfo;
      final data = info.data;

      // Ambil info dasar (universal)
      String model = data['model']?.toString() ?? 'Tidak diketahui';
      String brand = data['brand']?.toString() ?? 'Tidak diketahui';
      String version = data['version']?.toString() ?? 'Tidak diketahui';

      return {
        'Model': model,
        'Brand': brand,
        'Versi': version,
      };
    } catch (e) {
      return {'Error': 'Gagal memuat info perangkat'};
    }
  }

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
            height: 480,
            padding: const EdgeInsets.all(28.0),
            child: ListView(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.asset(
                      widget.avatarAsset ?? 'assets/logo.png',
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  widget.name ?? 'Pengguna',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.email,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ListTile(
                  leading: Icon(Icons.email, color: Colors.blue.shade700),
                  title: const Text('Email'),
                  subtitle: Text(widget.email),
                ),
                if (widget.name != null)
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.blue.shade700),
                    title: const Text('Nama'),
                    subtitle: Text(widget.name!),
                  ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.blue.shade700),
                  title: const Text('Pengaturan'),
                  subtitle: const Text('Ubah pengaturan akun Anda'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.info, color: Colors.blue.shade700),
                  title: const Text('Tentang Aplikasi'),
                  subtitle: const Text('Versi 1.0.0'),
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                FutureBuilder<Map<String, String>>(
                  future: getDeviceInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Text('Gagal memuat info perangkat');
                    } else {
                      final info = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          Text(
                            'Info Perangkat:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                              fontSize: 16,
                            ),
                          ),
                          ...info.entries.map(
                            (e) => Text('${e.key}: ${e.value}',
                                style: const TextStyle(fontSize: 14)),
                          ),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Kembali'),
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