import 'package:flutter/foundation.dart';
import '../models/productmodel.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartService {
  CartService._privateConstructor();
  static final CartService instance = CartService._privateConstructor();

  final ValueNotifier<List<CartItem>> itemsNotifier = ValueNotifier([]);
  final ValueNotifier<int> countNotifier = ValueNotifier(0);

  List<CartItem> get items => List.unmodifiable(itemsNotifier.value);

  void _updateNotifiers() {
    itemsNotifier.value = List.from(itemsNotifier.value);
    countNotifier.value = itemsNotifier.value.fold(0, (s, i) => s + i.quantity);
  }

  void add(Product product) {
    final list = itemsNotifier.value;
    final idx = list.indexWhere((e) => e.product.name == product.name);
    if (idx >= 0) {
      list[idx].quantity += 1;
    } else {
      list.add(CartItem(product: product, quantity: 1));
    }
    _updateNotifiers();
  }

  void remove(Product product) {
    final list = itemsNotifier.value;
    final idx = list.indexWhere((e) => e.product.name == product.name);
    if (idx >= 0) {
      list.removeAt(idx);
      _updateNotifiers();
    }
  }

  void changeQuantity(Product product, int quantity) {
    final list = itemsNotifier.value;
    final idx = list.indexWhere((e) => e.product.name == product.name);
    if (idx >= 0) {
      if (quantity <= 0) {
        list.removeAt(idx);
      } else {
        list[idx].quantity = quantity;
      }
      _updateNotifiers();
    }
  }

  void clear() {
    itemsNotifier.value = [];
    countNotifier.value = 0;
  }

  double get totalPrice => itemsNotifier.value.fold(0.0, (sum, it) => sum + it.product.price * it.quantity);
}
