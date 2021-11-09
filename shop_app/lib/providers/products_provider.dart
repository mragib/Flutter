import 'package:flutter/Material.dart';
import 'product.dart';
import '../dummy_product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = dummy_product;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favorites {
    return _items.where((item) => item.isFavorite).toList();
  }

  Product findById(String id) {
    return items.firstWhere((prod) => prod.id == id);
  }

  void addProduct() {
    notifyListeners();
  }
}
