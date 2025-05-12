import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController addressController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Shipping Info')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Shipping Address'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.go('/checkout/payment');
              },
              child: const Text('Next: Payment'),
            )
          ],
        ),
      ),
    );
  }
}
