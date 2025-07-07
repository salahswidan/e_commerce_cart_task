import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/cart_controller.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context);
    final promoController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          ...cartController.items.map<Widget>(
            (item) => ListTile(
              title: Text(
                item.product.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${(item.product.price * item.quantity).toStringAsFixed(2)} EGP',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton.filled(
                    style: IconButton.styleFrom(backgroundColor: Colors.blue),
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      cartController.decreaseQuantity(item.product.id);
                    },
                  ),
                  SizedBox(width: 5),
                  Text('${item.quantity}', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 5),
                  IconButton.filled(
                    style: IconButton.styleFrom(backgroundColor: Colors.blue),
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      cartController.increaseQuantity(item.product.id);
                    },
                  ),
                  SizedBox(width: 5),
                  IconButton.filled(
                    style: IconButton.styleFrom(backgroundColor: Colors.red),
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      cartController.removeProduct(item.product.id);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: promoController,
              decoration: InputDecoration(
                labelText: 'Promo Code',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    cartController.applyPromoCode(promoController.text);
                  },
                ),
              ),
            ),
          ),
          if (cartController.appliedPromoCode.isNotEmpty)
            Text('Promo "${cartController.appliedPromoCode}" applied ✅'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total: ${cartController.total.toStringAsFixed(2)} EGP',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
