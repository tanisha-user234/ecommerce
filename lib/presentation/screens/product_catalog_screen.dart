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
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: isGrid ? 'Switch to List View' : 'Switch to Grid View',
            icon: Icon(isGrid ? Icons.view_list : Icons.grid_view_rounded),
            onPressed: () => setState(() => isGrid = !isGrid),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: notifier.applySearch,
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          _buildSortDropdown(notifier),
          const SizedBox(height: 8),
          Expanded(
            child: state.filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.search_off, size: 80, color: Colors.grey),
                        SizedBox(height: 10),
                        Text('No products found',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey)),
                      ],
                    ),
                  )
                : AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isGrid
                        ? GridView.builder(
                            key: const ValueKey('grid'),
                            padding: const EdgeInsets.all(12),
                            itemCount: state.filteredProducts.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 4,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemBuilder: (context, index) =>
                                ProductCard(product: state.filteredProducts[index]),
                          )
                        : ListView.separated(
                            key: const ValueKey('list'),
                            padding: const EdgeInsets.all(12),
                            itemCount: state.filteredProducts.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                            itemBuilder: (context, index) =>
                                ProductCard(product: state.filteredProducts[index]),
                          ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortDropdown(ProductFilterNotifier notifier) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple, width: 1.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButton<SortOption>(
            value: ref.read(productFilterProvider).sortOption,
            icon: const Icon(Icons.arrow_drop_down),
            isExpanded: true,
            underline: const SizedBox(),
            onChanged: (sortOption) {
              if (sortOption != null) {
                notifier.applySort(sortOption);
              }
            },
            items: const [
              DropdownMenuItem(
                value: SortOption.priceLowToHigh,
                child: Text("Price: Low to High"),
              ),
              DropdownMenuItem(
                value: SortOption.priceHighToLow,
                child: Text("Price: High to Low"),
              ),
              DropdownMenuItem(
                value: SortOption.ratingHighToLow,
                child: Text("Rating: High to Low"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
