import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../presentation/screens/product_catalog_screen.dart';

class AppRouter {
  final GoRouter config = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductCatalogScreen(),
      ),
    ],
  );
}
