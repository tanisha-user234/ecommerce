import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedMethod = 'Cash on Delivery';

    return Scaffold(
      appBar: AppBar(title: const Text('Payment Method')),
      body: Column(
        children: [
          RadioListTile(
            value: 'Cash on Delivery',
            groupValue: selectedMethod,
            onChanged: (_) {},
            title: const Text('Cash on Delivery'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/checkout/confirm');
            },
            child: const Text('Next: Confirm Order'),
          )
        ],
      ),
    );
  }
}
