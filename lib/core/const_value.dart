import 'package:e_commerce_cart_task/model/product_model.dart';

class ConstValue {
  static final List<Product> products = [
      Product(
        id: '1',
        name: 'Phone',
        price: 4000,
        image: "assets/images/Apple-iPhone-12-PNG-HD.png",
      ),
      Product(
        id: '2',
        name: 'Laptop',
        price: 9000,
        image: "assets/images/Laptop-Top-View-PNG-Picture.png",
      ),
      Product(
        id: '3',
        name: 'Headphones',
        price: 1500,
        image: "assets/images/Air-Pods-PNG-File.webp",
      ),
    ];
}