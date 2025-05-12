import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import '../../../domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (_, __, ___) => ProductDetailScreen(product: product),
    transitionsBuilder: (_, animation, __, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    transitionDuration: const Duration(milliseconds: 400),
  ),
),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.imageUrl.startsWith('assets/')
    ? Image.asset(product.imageUrl, height: 100, width: double.infinity, fit: BoxFit.cover)
    : Text('Image not available', style: TextStyle(color: Colors.red)),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text("₹${product.price.toStringAsFixed(2)}"),
            ),
          ],
        ),
      ),
    );
  }
}
