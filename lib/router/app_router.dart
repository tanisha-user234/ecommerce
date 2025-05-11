import 'package:ecommerce/presentation/screens/checkout/order_conformation_screen.dart';
import 'package:ecommerce/presentation/screens/checkout/payment_screen.dart';
import 'package:ecommerce/presentation/screens/checkout/shipping_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../presentation/screens/product_catalog_screen.dart';
import '../presentation/screens/cart_screen.dart';
import '../presentation/screens/checkout_screen.dart';
class AppRouter {
  final GoRouter config = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductCatalogScreen(),
      ),
      GoRoute(
  path: '/cart',
  builder: (context, state) => const CartScreen(),
),
GoRoute(
  path: '/checkout',
  builder: (context, state) => const CheckoutScreen(),
),
GoRoute(path: '/checkout/shipping', builder: (context, state) => const ShippingScreen()),
GoRoute(path: '/checkout/payment', builder: (context, state) => const PaymentScreen()),
GoRoute(path: '/checkout/confirm', builder: (context, state) => const OrderConfirmationScreen()),

    ],
  );
}
