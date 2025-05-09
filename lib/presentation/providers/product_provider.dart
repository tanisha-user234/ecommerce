import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../data/repositories/product_repository_impl.dart';
import '../../../data/datasources/product_local_datasource.dart';
import '../../../domain/usecases/get_all_products.dart';

final productProvider = FutureProvider<List<ProductEntity>>((ref) async {
  final repository = ProductRepositoryImpl(ProductLocalDataSource());
  final getProducts = GetAllProducts(repository);
  return getProducts();
});
