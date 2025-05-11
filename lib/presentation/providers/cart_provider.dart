import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../data/models/cart_item_model.dart';

class CartNotifier extends StateNotifier<List<CartItemModel>> {
  CartNotifier() : super([]) {
    _loadCart();
  }

  final _box = Hive.box<CartItemModel>('cartBox');

  void _loadCart() {
    state = _box.values.toList();
  }

  void addToCart(CartItemModel item) {
    final index = state.indexWhere((i) => i.id == item.id && i.variant == item.variant);
    if (index >= 0) {
      final updated = state[index].copyWith(quantity: state[index].quantity + 1);
      _box.putAt(index, updated);
    } else {
      _box.add(item);
    }
    _loadCart();
  }

  void removeFromCart(CartItemModel item) {
    final index = state.indexWhere((i) => i.id == item.id && i.variant == item.variant);
    if (index >= 0) {
      _box.deleteAt(index);
      _loadCart();
    }
  }

  void updateQuantity(CartItemModel item, int quantity) {
    final index = state.indexWhere((i) => i.id == item.id && i.variant == item.variant);
    if (index >= 0) {
      final updated = item.copyWith(quantity: quantity);
      _box.putAt(index, updated);
      _loadCart();
    }
  }

  void clearCart() {
    _box.clear();
    _loadCart();
  }

  double get total => state.fold(0, (sum, item) => sum + item.price * item.quantity);
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItemModel>>(
  (ref) => CartNotifier(),
);
