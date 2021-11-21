import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;
import 'product.dart';
import '../models/http_exception.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favorites {
    return _items.where((item) => item.isFavorite).toList();
  }

  Product findById(String? id) {
    return items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fatchAndSetData() async {
    const url =
        'https://flutter-shop-ba823-default-rtdb.asia-southeast1.firebasedatabase.app/products.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> _loadedData = [];
      extractData.forEach((prodId, prodData) {
        _loadedData.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
          ),
        );
        _items = _loadedData;
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    const url =
        'https://flutter-shop-ba823-default-rtdb.asia-southeast1.firebasedatabase.app/products.json';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        description: product.description,
        title: product.title,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product updatedProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    final url =
        'https://flutter-shop-ba823-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json';
    try {
      final res = http.patch(Uri.parse(url),
          body: json.encode({
            'title': updatedProduct.title,
            'description': updatedProduct.description,
            'price': updatedProduct.price,
            'imageUrl': updatedProduct.imageUrl,
          }));
      _items[prodIndex] = updatedProduct;
      notifyListeners();
    } catch (error) {
      print(error);

      throw error;
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://flutter-shop-ba823-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json';
    final exietingProductIndex =
        _items.indexWhere((element) => element.id == id);
    Product? exietongProduct = _items[exietingProductIndex];

    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();

    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(exietingProductIndex, exietongProduct);
      notifyListeners();

      throw HttpException('Could not Delete');
    }
    exietongProduct = null;
  }
}
