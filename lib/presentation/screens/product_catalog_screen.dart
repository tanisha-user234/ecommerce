import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_filter_notifier.dart';
import '../widgets/product_card.dart';

class ProductCatalogScreen extends ConsumerStatefulWidget {
  const ProductCatalogScreen({super.key});

  @override
  ConsumerState<ProductCatalogScreen> createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends ConsumerState<ProductCatalogScreen> {
  bool isGrid = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productFilterProvider);
    final notifier = ref.read(productFilterProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view),
            onPressed: () => setState(() => isGrid = !isGrid),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: notifier.applySearch,
              decoration: const InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSortDropdown(notifier),
          Expanded(
            child: state.filteredProducts.isEmpty
                ? const Center(child: Text('No products found'))
                : isGrid
                    ? GridView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: state.filteredProducts.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 3 / 4, crossAxisSpacing: 8, mainAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          return ProductCard(product: state.filteredProducts[index]);
                        },
                      )
                    : ListView.builder(
                        itemCount: state.filteredProducts.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: state.filteredProducts[index]);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortDropdown(ProductFilterNotifier notifier) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DropdownButton<SortOption>(
        hint: const Text("Sort by"),
        value: ref.read(productFilterProvider).sortOption,
        onChanged: (sortOption) {
          if (sortOption != null) {
            notifier.applySort(sortOption);
          }
        },
        isExpanded: true,
        items: const [
          DropdownMenuItem(value: SortOption.priceLowToHigh, child: Text("Price: Low to High")),
          DropdownMenuItem(value: SortOption.priceHighToLow, child: Text("Price: High to Low")),
          DropdownMenuItem(value: SortOption.ratingHighToLow, child: Text("Rating: High to Low")),
        ],
      ),
    );
  }
}
