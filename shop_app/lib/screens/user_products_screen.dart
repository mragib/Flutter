import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';
import './edit_user_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routerName = '/user-product';
  const UserProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditUserProductScreen.routerName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (_, i) => Column(
                  children: [
                    UserProductItem(
                      title: productData.items[i].title,
                      imageUrl: productData.items[i].imageUrl,
                    ),
                    const Divider(),
                  ],
                )),
      ),
    );
  }
}
