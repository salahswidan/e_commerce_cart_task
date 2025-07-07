import 'package:e_commerce_cart_task/controller/dicount_strategy.dart';


class NoDiscount implements DiscountStrategy {
  @override
  double applyDiscount(double total) {
    return total;
  }
}
