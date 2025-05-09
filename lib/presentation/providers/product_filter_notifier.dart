import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../data/datasources/product_local_datasource.dart';
import '../../../data/repositories/product_repository_impl.dart';
import '../../../domain/usecases/get_all_products.dart';

enum SortOption { priceLowToHigh, priceHighToLow, ratingHighToLow }

class ProductFilterState {
  final List<ProductEntity> allProducts;
  final List<ProductEntity> filteredProducts;
  final String searchQuery;
  final SortOption? sortOption;

  ProductFilterState({
    required this.allProducts,
    required this.filteredProducts,
    this.searchQuery = '',
    this.sortOption,
  });

  ProductFilterState copyWith({
    List<ProductEntity>? allProducts,
    List<ProductEntity>? filteredProducts,
    String? searchQuery,
    SortOption? sortOption,
  }) {
    return ProductFilterState(
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      searchQuery: searchQuery ?? this.searchQuery,
      sortOption: sortOption ?? this.sortOption,
    );
  }
}

class ProductFilterNotifier extends StateNotifier<ProductFilterState> {
  ProductFilterNotifier() : super(ProductFilterState(allProducts: [], filteredProducts: [])) {
    _loadProducts();
  }

  void _loadProducts() async {
    final repository = ProductRepositoryImpl(ProductLocalDataSource());
    final getProducts = GetAllProducts(repository);
    final products = await getProducts();
    state = state.copyWith(allProducts: products, filteredProducts: products);
  }

  void applySearch(String query) {
    final filtered = state.allProducts.where((p) =>
      p.name.toLowerCase().contains(query.toLowerCase())).toList();
    state = state.copyWith(searchQuery: query, filteredProducts: filtered);
  }

  void applySort(SortOption option) {
    List<ProductEntity> sorted = [...state.filteredProducts];
    switch (option) {
      case SortOption.priceLowToHigh:
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceHighToLow:
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.ratingHighToLow:
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    state = state.copyWith(sortOption: option, filteredProducts: sorted);
  }
}

final productFilterProvider = StateNotifierProvider<ProductFilterNotifier, ProductFilterState>(
  (ref) => ProductFilterNotifier(),
);
