import 'package:flutter/foundation.dart';

class CartItem2 {
  final String id;


  CartItem2(
      {required this.id,});
}

class Cart2 with ChangeNotifier {
  Map<String, CartItem2> _items = {};

  Map<String, CartItem2> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String pdtid) {
    if (_items.containsKey(pdtid)) {
      _items.update(
          pdtid,
          (existingCartItem) => CartItem2(
              id:pdtid,
            )
      );
    } else {
      _items.putIfAbsent(
          pdtid,
          () => CartItem2(

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
