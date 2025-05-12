import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce/domain/entities/product_entity.dart';
import 'package:ecommerce/domain/usecases/get_all_products.dart';
import 'package:ecommerce/domain/repositories/product_repository.dart';

// Mock repository for testing
class FakeProductRepository implements ProductRepository {
  @override
  Future<List<ProductEntity>> getAllProducts() async {
    return [
      ProductEntity(
        id: '1',
        name: 'Mock Product',
        description: 'A product for testing',
        price: 999.99,
        imageUrl: 'https://via.placeholder.com/150',
        categories: ['Test'],
        rating: 4.5,
        variants: ['S', 'M'],
      ),
    ];
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Get all products returns non-empty list', () async {
    final useCase = GetAllProducts(FakeProductRepository());
    final result = await useCase();

    expect(result.isNotEmpty, true);
    expect(result.first.name, 'Mock Product');
  });
}
