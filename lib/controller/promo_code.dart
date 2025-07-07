import 'package:e_commerce_cart_task/controller/dicount_strategy.dart';

class PromoCode implements DiscountStrategy {
  final String promoCode;
  final double discountPercentage;

  PromoCode({required this.promoCode, required this.discountPercentage});

  @override
  double applyDiscount(double total) {
    return total - (total * discountPercentage / 100);
  }
}
