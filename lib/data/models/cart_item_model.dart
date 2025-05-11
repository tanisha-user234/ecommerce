import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItemModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final String variant;
  @HiveField(5)
  final int quantity;

  CartItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.variant,
    required this.quantity,
  });

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      variant: variant,
      quantity: quantity ?? this.quantity,
    );
  }
}
