import 'package:flutter/foundation.dart';

class CartItem1 {
  final String id;


  CartItem1(
      {required this.id,});
}

class Cart1 with ChangeNotifier {
  Map<String, CartItem1> _items = {};

  Map<String, CartItem1> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String pdtid) {
    if (_items.containsKey(pdtid)) {
      _items.update(
          pdtid,
          (existingCartItem) => CartItem1(
              id:pdtid,
            )
      );
    } else {
      _items.putIfAbsent(
          pdtid,
          () => CartItem1(

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
