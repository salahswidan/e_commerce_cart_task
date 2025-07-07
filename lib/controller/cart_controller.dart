import 'package:e_commerce_cart_task/controller/no_discount.dart';
import 'package:e_commerce_cart_task/controller/promo_code.dart';
import 'package:e_commerce_cart_task/services/cart_services.dart';
import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  final CartService cartService;
  String appliedPromoCode = '';

  CartController({required this.cartService});

  void removeProduct(String productId) {
    cartService.removeFromCart(productId);
    notifyListeners();
  }

  void applyPromoCode(String code) {
    final trimmedCode = code.trim();
    final discountValue = int.tryParse(trimmedCode);

    if (discountValue != null && discountValue > 0 && discountValue < 100) {
      cartService.applyDiscountStrategy(
        PromoCode(
          promoCode: trimmedCode,
          discountPercentage: discountValue.toDouble(),
        ),
      );
      appliedPromoCode = trimmedCode;
    } else {
      cartService.applyDiscountStrategy(NoDiscount());
      appliedPromoCode = '';
    }

    notifyListeners();
  }

  void increaseQuantity(String productId) {
    cartService.increaseQuantity(productId);
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    cartService.decreaseQuantity(productId);
    notifyListeners();
  }

  void addProduct(product) {
    cartService.addToCart(product);
    notifyListeners();
  }

  double get total {
    return cartService.getTotalPrice;
  }

  List get items {
    return cartService.items;
  }
}
