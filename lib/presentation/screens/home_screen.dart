import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(title: const Text('E-Commerce App')),
      body: const Center(child: Text('Welcome to the Product Catalog')),
    );
  }
}