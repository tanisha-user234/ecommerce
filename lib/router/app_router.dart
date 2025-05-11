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
    ],
  );
}
