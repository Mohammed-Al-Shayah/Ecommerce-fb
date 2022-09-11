import 'package:flutter/foundation.dart';

class CartItem {
  final String id;


  CartItem(
      {required this.id,});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String pdtid) {
    if (_items.containsKey(pdtid)) {
      _items.update(
          pdtid,
          (existingCartItem) => CartItem(
              id:pdtid,
            )
      );
    } else {
      _items.putIfAbsent(
          pdtid,
          () => CartItem(

                id:pdtid,


              ));
    }
    notifyListeners();
  }
  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }


  void clear() {
    _items = {};
    notifyListeners();
  }
}
