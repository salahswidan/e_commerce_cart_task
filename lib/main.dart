import 'package:e_commerce_cart_task/controller/no_discount.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/cart_controller.dart';
import 'services/cart_services.dart';
import 'views/home_view.dart';
import 'views/cart_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cartService = CartService(discountStrategy: NoDiscount());
  await cartService.loadCartFromPref();
  runApp(MyApp(cartService: cartService));
}

class MyApp extends StatelessWidget {
  final CartService cartService;

  const MyApp({super.key, required this.cartService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartController(cartService: cartService),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Cart',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeView(),
        routes: {'/cart': (_) => const CartView()},
      ),
    );
  }
}
