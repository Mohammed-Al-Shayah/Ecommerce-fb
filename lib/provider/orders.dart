import 'package:flutter/cupertino.dart';

class FavoriteProducts {

  final String id;

  FavoriteProducts({
    required this.id,
  }
  );
}

class FavProducts with ChangeNotifier {
  Map<String, FavoriteProducts> _fProducts = {};

  Map<String, FavoriteProducts> get favProduct {
    return {..._fProducts};
  }

  int get itemCount {
    return _fProducts.length;
  }

  void addFavProduct(String pdtid) {
    if (_fProducts.containsKey(pdtid)) {
      _fProducts.update(
          pdtid,
          (existingCartItem) => FavoriteProducts(
                id: pdtid,
              ));
    } else {
      _fProducts.putIfAbsent(
          pdtid,
          () => FavoriteProducts(
                id: pdtid,
              ));
    }
    notifyListeners();
  }

  void removeFavProduct(String id) {
    _fProducts.remove(id);
    notifyListeners();
  }

  void clearAllFavProducts(){
    _fProducts = {};
    notifyListeners();
  }
}
