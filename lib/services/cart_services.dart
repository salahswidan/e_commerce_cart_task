import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce_cart_task/controller/dicount_strategy.dart';
import 'package:e_commerce_cart_task/model/cart_item_model.dart';
import 'package:e_commerce_cart_task/model/product_model.dart';

class CartService {
  final List<CartItem> _items = [];
  DiscountStrategy _discountStrategy;

  static const String _cartKey = 'cart_items';
  static const String _totalKey = 'total_price';

  double _storedTotalPrice = 0;

  double get storeTotalPrice {
    return _storedTotalPrice;
  }

  CartService({required DiscountStrategy discountStrategy})
    : _discountStrategy = discountStrategy;

  void applyDiscountStrategy(DiscountStrategy strategy) {
    _discountStrategy = strategy;
  }

  bool isTesting = false;

  Future<void> _saveCartToPref() async {
    if (isTesting) return;
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_items.map((e) => e.toJson()).toList());
    await prefs.setString(_cartKey, jsonString);
  }

  Future<void> loadCartFromPref() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString(_cartKey);
    final savedTotal = prefs.getDouble(_totalKey);

    if (cartJson != null) {
      final List decoded = jsonDecode(cartJson);
      _items.clear();
      _items.addAll(decoded.map((e) => CartItem.fromJson(e)).toList());
    }

    if (savedTotal != null) {
      _storedTotalPrice = savedTotal;
    }
  }

  void _updateCart() {
    _saveCartToPref();
    _saveTotalPrice();
  }

  Future<void> _saveTotalPrice() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_totalKey, getTotalPrice);
  }

  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    _updateCart();
  }

  void removeFromCart(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    _updateCart();
  }

  void increaseQuantity(String productId) {
    try {
      final item = _items.firstWhere((item) => item.product.id == productId);
      item.quantity++;
    } catch (e) {
      print('Error in increaseQuantity: $e');
    }
    _updateCart();
  }

  void decreaseQuantity(String productId) {
    try {
      final item = _items.firstWhere((item) => item.product.id == productId);
      if (item.quantity > 1) {
        item.quantity--;
      } else {
        removeFromCart(productId);
        return;
      }
    } catch (e) {
      print('Error in decreaseQuantity: $e');
    }
    _updateCart();
  }

  List<CartItem> get items => _items;

  double get getTotalPrice {
    double total = 0;
    for (var item in _items) {
      total += item.product.price * item.quantity;
    }
    return _discountStrategy.applyDiscount(total);
  }
}
