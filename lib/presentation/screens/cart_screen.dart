import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final total = ref.read(cartProvider.notifier).total;

    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        leading: Image.network(item.imageUrl, width: 50),
                        title: Text(item.name),
                        subtitle: Text("₹${item.price} × ${item.quantity} (${item.variant})"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => ref.read(cartProvider.notifier).removeFromCart(item),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Total: ₹${total.toStringAsFixed(2)}'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/checkout');
                  },
                  child: const Text('Proceed to Checkout'),
                )
              ],
            ),
    );
  }
}
