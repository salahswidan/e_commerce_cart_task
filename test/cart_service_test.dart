import 'package:flutter_test/flutter_test.dart';
import 'package:e_commerce_cart_task/model/product_model.dart';
import 'package:e_commerce_cart_task/services/cart_services.dart';
import 'package:e_commerce_cart_task/controller/no_discount.dart';
import 'package:e_commerce_cart_task/controller/promo_code.dart';

void main() {
  group('CartService', () {
    late CartService cartService;
    late Product product;

    setUp(() {
      cartService.isTesting = true;
      cartService = CartService(discountStrategy: NoDiscount());
      product = Product(
        id: '1',
        name: 'Laptop',
        price: 10000,
        image: 'img.png',
      );
    });

    test('Add product increases items count', () {
      cartService.addToCart(product);
      expect(cartService.items.length, 1);
    });

    test('Add same product increases quantity', () {
      cartService.addToCart(product);
      cartService.addToCart(product);
      expect(cartService.items[0].quantity, 2);
    });

    test('Remove product deletes it', () {
      cartService.addToCart(product);
      cartService.removeFromCart(product.id);
      expect(cartService.items.length, 0);
    });

    test('Total price is correct without discount', () {
      cartService.addToCart(product);
      expect(cartService.getTotalPrice, 10000);
    });

    test('Total price with promo discount', () {
      cartService.addToCart(product);
      cartService.applyDiscountStrategy(
        PromoCode(promoCode: '10', discountPercentage: 10),
      );
      expect(cartService.getTotalPrice, 9000);
    });

    test('Increase and decrease quantity work', () {
      cartService.addToCart(product);
      cartService.increaseQuantity(product.id);
      expect(cartService.items[0].quantity, 2);

      cartService.decreaseQuantity(product.id);
      expect(cartService.items[0].quantity, 1);
    });

    test('Decrease quantity to 0 removes item', () {
      cartService.addToCart(product);
      cartService.decreaseQuantity(product.id);
      expect(cartService.items.length, 0);
    });
  });
}
