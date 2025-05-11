import 'package:flutter/material.dart';
import '../../../domain/entities/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';
import '../../../data/models/cart_item_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? selectedVariant;

  @override
  void initState() {
    super.initState();
    selectedVariant = widget.product.variants.isNotEmpty ? widget.product.variants[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image gallery
            Center(
              child: Image.network(product.imageUrl, height: 200),
            ),
            const SizedBox(height: 16),
            Text(product.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('₹${product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(product.description),
            const SizedBox(height: 16),

            // Variant selector
            if (product.variants.isNotEmpty) ...[
              const Text("Select Variant:", style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8,
                children: product.variants.map((variant) {
                  final isSelected = selectedVariant == variant;
                  return ChoiceChip(
                    label: Text(variant),
                    selected: isSelected,
                    onSelected: (_) => setState(() => selectedVariant = variant),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],

            // Reviews
            const Text("Customer Reviews", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildMockReviews(),
            Consumer(
  builder: (context, ref, _) {
    return ElevatedButton(
      onPressed: () {
        final cartItem = CartItemModel(
          id: product.id,
          name: product.name,
          price: product.price,
          imageUrl: product.imageUrl,
          variant: selectedVariant ?? '',
          quantity: 1,
        );
        ref.read(cartProvider.notifier).addToCart(cartItem);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Added to cart')),
        );
      },
      child: const Text('Add to Cart'),
    );
  },
),

          ],
        ),
        
      ),
    );
  }

  Widget _buildMockReviews() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text("Nice quality"),
          subtitle: const Text("Very satisfied with the product."),
          trailing: const Icon(Icons.star, color: Colors.amber),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text("Fast delivery"),
          subtitle: const Text("Got it in 2 days. Recommended."),
          trailing: const Icon(Icons.star, color: Colors.amber),
        ),
      ],
    );
  }
}
