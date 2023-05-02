import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:mad_final/models/product.dart';

class ProductNotifier extends ChangeNotifier {
  List<Product> _productList = [];

  UnmodifiableListView<Product> get productList => UnmodifiableListView(_productList);

  addProduct(Product product) 
  {
    _productList.add(product);
    notifyListeners();
  }

  deleteProduct(index) 
  {
    _productList.removeWhere((_product) => _product.name == productList[index].name);
    notifyListeners();
  }
}