import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'models/productmodel.dart';
import 'utils/formatters.dart';
import 'services/cart_service.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.product.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.product.image,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.product.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              widget.product.description,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              widget.product is DiscountProduct
                  ? 'Harga: ${formatCurrency((widget.product as DiscountProduct).discountedPrice)} (Diskon ${(widget.product as DiscountProduct).discount.toStringAsFixed(0)}%)'
                  : 'Harga: ${formatCurrency(widget.product.price)}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            RatingStars(
              value: _rating,
              onValueChanged: (v) {
                setState(() {
                  _rating = v;
                  widget.product.rating = v;
                });
              },
              starCount: 5,
              starSize: 32,
              maxValue: 5,
              starSpacing: 2,
              maxValueVisibility: true,
              valueLabelVisibility: true,
              animationDuration: Duration(milliseconds: 300),
              valueLabelRadius: 12,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                CartService.instance.add(widget.product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${widget.product.name} ditambahkan ke keranjang')),
                );
              },
              child: const Text('Tambah ke Keranjang'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}