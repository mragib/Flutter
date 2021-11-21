import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/user_products_screen.dart';
import './screens/orders_screen.dart';
import './screens/cart_screen.dart';
import './screens/product_details_screen.dart';
import './screens/producr_overview_screen.dart';
import './screens/edit_user_product_screen.dart';

import './providers/products_provider.dart';
import './providers/orders_provider.dart';
import './providers/cart_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrdersProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: "Lato",
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailsScreen.routerName: (ctx) =>
              const ProductDetailsScreen(),
          CartScreen.routerName: (ctx) => const CartScreen(),
          OrderScreen.routerName: (ctx) => const OrderScreen(),
          UserProductScreen.routerName: (ctx) => const UserProductScreen(),
          EditUserProductScreen.routerName: (ctx) =>
              const EditUserProductScreen(),
        },
      ),
    );
  }
}
