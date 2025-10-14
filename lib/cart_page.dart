import 'package:flutter/material.dart';
import 'services/cart_service.dart';
import 'utils/formatters.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = CartService.instance;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: ValueListenableBuilder(
        valueListenable: cart.itemsNotifier,
        builder: (context, List items, _) {
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.shopping_cart, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('Keranjang kosong', style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final it = items[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(it.product.image, width: 64, height: 64, fit: BoxFit.cover),
                          ),
                          title: Text(it.product.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text(formatCurrency(it.product.price)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () => cart.changeQuantity(it.product, it.quantity - 1),
                              ),
                              Text('${it.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () => cart.changeQuantity(it.product, it.quantity + 1),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(formatCurrency(cart.totalPrice), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: ElevatedButton(
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Konfirmasi Pembelian'),
                        content: Text('Total: ${formatCurrency(cart.totalPrice)}\nLanjutkan pembelian?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
                          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Beli Sekarang')),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      cart.clear();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pembelian berhasil')));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Beli Sekarang'),
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
