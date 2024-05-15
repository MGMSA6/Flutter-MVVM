import 'package:flutter/widgets.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModal with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("token", user.token.toString());
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token").toString();

    notifyListeners();
    return UserModel(token: token);
  }

  Future<bool> remove() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    notifyListeners();
    return sharedPreferences.clear();
  }
}
