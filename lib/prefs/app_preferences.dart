import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences{
  static final AppPreferences _instance = AppPreferences._internal();

  late SharedPreferences _sharedPreferences;


  AppPreferences._internal();

  factory AppPreferences() {
    return _instance;
  }
  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> SaveProductInCart({required int Proid}) async {
    await _sharedPreferences.setInt('ProductId',Proid);
  }
  int get note => _sharedPreferences.getInt('Counter') ?? 0;

}