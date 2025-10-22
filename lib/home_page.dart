import 'package:flutter/material.dart';
import 'models/productmodel.dart';
import 'models/categorymodel.dart';
import 'product_detail_page.dart';
import 'profile_page.dart';
import 'cart_page.dart';
import 'services/cart_service.dart';
import 'category_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';
// getwidget removed - not used anymore

class HomePage extends StatelessWidget {
  final String email;
  final VoidCallback onLogout;

  HomePage({super.key, required this.email, required this.onLogout});

  final List<Category> categories = [
    Category(
      name: 'Kaos',
      description: 'Berbagai macam kaos polos dan motif.',
      assetImage: 'assets/kaos.png',
    ),
    PremiumCategory(
      name: 'Kemeja',
      description: 'Kemeja flanel dan formal premium.',
      assetImage: 'assets/kemeja.png',
      badge: 'Premium',
    ),
    Category(
      name: 'Jaket',
      description: 'Jaket hoodie dan bomber kekinian.',
      assetImage: 'assets/jaket.png',
    ),
    Category(
      name: 'Celana',
      description: 'Celana jeans dan chino stylish.',
      assetImage: 'assets/celana.png',
    ),
    PremiumCategory(
      name: 'Dress',
      description: 'Dress wanita elegan dan eksklusif.',
      assetImage: 'assets/dress.png',
      badge: 'Premium',
    ),
  ];

  final List<Product> kaosList = [
    Product(
      name: 'Kaos Polos Hitam',
      description: 'Kaos polos warna hitam, bahan katun.',
      image: 'assets/kaos hitam.png',
      price: 50000,
    ),
    Product(
      name: 'Kaos Polos Putih',
      description: 'Kaos polos warna putih, bahan katun.',
      image: 'assets/kaos putih.png',
      price: 50000,
    ),
    Product(
      name: 'Kaos Motif Garis',
      description: 'Kaos motif garis, trendy dan nyaman.',
      image: 'assets/kaos garis.png',
      price: 60000,
    ),
  ];

  final List<Product> jaketList = [
    Product(
      name: 'Jaket Hoodie',
      description: 'Jaket hoodie hangat dan stylish.',
      image: 'assets/jaket hoodie.png',
      price: 150000,
    ),
    Product(
      name: 'Jaket Bomber',
      description: 'Jaket bomber kekinian.',
      image: 'assets/jaket bomber.png',
      price: 170000,
    ),
    Product(
      name: 'Jaket Jeans',
      description: 'Jaket jeans klasik.',
      image: 'assets/jaket jeans.png',
      price: 180000,
    ),
  ];

  final List<Product> kemejaList = [
    DiscountProduct(
      name: 'Kemeja Flanel',
      description: 'Kemeja flanel motif kotak, diskon spesial!',
      image: 'assets/kemeja flanel.png',
      price: 120000,
      discount: 20,
    ),
    Product(
      name: 'Kemeja Putih Formal',
      description: 'Kemeja putih formal, cocok untuk kerja.',
      image: 'assets/kemeja putih.png',
      price: 110000,
    ),
    Product(
      name: 'Kemeja Batik',
      description: 'Kemeja batik elegan.',
      image: 'assets/kemeja batik.png',
      price: 130000,
    ),
  ];

  final List<Product> celanaList = [
    DiscountProduct(
      name: 'Celana Jeans',
      description: 'Celana jeans model terbaru, diskon 10%.',
      image: 'assets/celana jeans.png',
      price: 200000,
      discount: 10,
    ),
    Product(
      name: 'Celana Chino',
      description: 'Celana chino stylish.',
      image: 'assets/celana chino.png',
      price: 180000,
    ),
    Product(
      name: 'Celana Pendek',
      description: 'Celana pendek santai.',
      image: 'assets/celana pendek.png',
      price: 90000,
    ),
  ];

  final List<Product> dressList = [
    Product(
      name: 'Dress Wanita Elegan',
      description: 'Dress wanita elegan untuk acara spesial.',
      image: 'assets/dress elegan.png',
      price: 180000,
    ),
    Product(
      name: 'Dress Casual',
      description: 'Dress casual untuk sehari-hari.',
      image: 'assets/dress casual.png',
      price: 150000,
    ),
    Product(
      name: 'Dress Pesta',
      description: 'Dress pesta mewah dan eksklusif.',
      image: 'assets/dress pesta.png',
      price: 250000,
    ),
  ];

  Widget buildProductSection(String title, List<Product> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final p = list[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 3,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    p.image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  p.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  p.info,
                  style: TextStyle(color: Colors.blue.shade700),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined, color: Colors.blue),
                  onPressed: () {
                    CartService.instance.add(p);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${p.name} ditambahkan ke keranjang')));
                  },
                ),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product: p),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Baju'),
        backgroundColor: const Color.fromARGB(255, 126, 0, 230),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            color: const Color.fromARGB(255, 32, 31, 31),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(email: email, name: 'Nama Pengguna'),
                ),
              );
            },
          ),
          ValueListenableBuilder<int>(
            valueListenable: CartService.instance.countNotifier,
            builder: (context, count, _) => Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
                  },
                ),
                if (count > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      child: Text('$count', style: const TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.white,
            onPressed: onLogout,
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/bg_login.jpg', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
                    ],
                  ),
                  child: Text(
                    'Selamat datang, $email',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 17, 17, 17),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Menu Kategori',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 238, 240, 243),
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // ErigoStore quick link card
                      InkWell(
                        onTap: () async {
                          final uri = Uri.parse('https://erigostore.co.id/');
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Tidak dapat membuka situs')),
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Card(
                          color: Colors.white.withOpacity(0.95),
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Image.asset('assets/logo.png', width: 48, height: 48),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text('Kunjungi ErigoStore', style: TextStyle(fontWeight: FontWeight.bold)),
                                      SizedBox(height: 4),
                                      Text('Lihat koleksi lengkap di erigostore.co.id', style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.open_in_new, color: Colors.blue),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  childAspectRatio: 0.95,
                  children: [
                    _buildMenuCard(context, 'Kaos', kaosList, 'assets/kaos.png'),
                    _buildMenuCard(context, 'Kemeja', kemejaList, 'assets/kemeja.png'),
                    _buildMenuCard(context, 'Jaket', jaketList, 'assets/jaket.png'),
                    _buildMenuCard(context, 'Celana', celanaList, 'assets/celana.png'),
                    _buildMenuCard(context, 'Dress', dressList, 'assets/dress.png'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ValueListenableBuilder<int>(
        valueListenable: CartService.instance.countNotifier,
        builder: (context, count, _) => FloatingActionButton.extended(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage())),
          label: Text('Keranjang${count > 0 ? ' ($count)' : ''}'),
          icon: const Icon(Icons.shopping_cart),
          backgroundColor: Colors.blue.shade700,
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, List<Product> products, String assetImage) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.blue.shade100,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailPage(
                category: Category(
                  name: title,
                  description: 'Daftar $title pilihan terbaik.',
                  assetImage: assetImage,
                ),
                products: products,
              ),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade100.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 38,
                backgroundColor: Colors.blue.shade50,
                child: ClipOval(
                  child: Image.asset(assetImage, width: 54, height: 54, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blue.shade700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Lihat produk $title',
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

}