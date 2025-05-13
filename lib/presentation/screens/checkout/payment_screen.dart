import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedMethod = 'Cash on Delivery';

    return Scaffold(
       appBar: AppBar(
        title: const Text('Payment Method'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Column(
        children: [
          RadioListTile(
            value: 'Cash on Delivery',
            groupValue: selectedMethod,
            onChanged: (_) {},
            title: const Text('Cash on Delivery'),
          ),
          RadioListTile(
            value: 'Online Payment',
            groupValue: selectedMethod,
            onChanged: (_) {},
            title: const Text('Online Payment'),
          ),
          RadioListTile(
            value: 'Credit Card',
            groupValue: selectedMethod,
            onChanged: (_) {},
            title: const Text('Credit Card'),
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
