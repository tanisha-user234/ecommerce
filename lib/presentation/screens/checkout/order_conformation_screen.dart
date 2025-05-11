import 'package:ecommerce/presentation/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderConfirmationScreen extends ConsumerWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final total = ref.read(cartProvider.notifier).total;
    final tax = total * 0.10;
    final shipping = 50.0;
    final finalTotal = total + tax + shipping;

    return Scaffold(
      appBar: AppBar(title: const Text('Order Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Items: ₹${total.toStringAsFixed(2)}'),
            Text('Tax (10%): ₹${tax.toStringAsFixed(2)}'),
            Text('Shipping: ₹${shipping.toStringAsFixed(2)}'),
            const Divider(),
            Text('Total: ₹${finalTotal.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(cartProvider.notifier).clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order Confirmed!')),
                );
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Place Order'),
            )
          ],
        ),
      ),
    );
  }
}
