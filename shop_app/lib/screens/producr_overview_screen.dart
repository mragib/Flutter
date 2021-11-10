import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import './cart_screen.dart';
import '../widgets/badge.dart';
import '../widgets/product_grid.dart';

enum filterProduct { favorite, all }

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Shop'),
          actions: [
            PopupMenuButton(
              onSelected: (filterProduct seletedValue) {
                setState(() {
                  if (seletedValue == filterProduct.favorite) {
                    _isFavorite = true;
                  } else {
                    _isFavorite = false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  child: Text('Only Favorite'),
                  value: filterProduct.favorite,
                ),
                const PopupMenuItem(
                  child: Text('Show All'),
                  value: filterProduct.all,
                ),
              ],
            ),
            Consumer<CartProvider>(
              builder: (_, cartData, ch) => Badge(
                child: ch as Widget,
                value: cartData.itemCount.toString(),
              ),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routerName);
                },
              ),
            ),
          ],
        ),
        body: ProductGrid(_isFavorite));
  }
}
