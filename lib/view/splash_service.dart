import 'package:flutter/cupertino.dart';
import 'package:mvvm/utils/routes/route_names.dart';
import 'package:mvvm/view_model/user_view_modal.dart';

import '../model/user_model.dart';

class SplashService {
  Future<UserModel> getUserData() => UserViewModal().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((onValue) async {
      if (onValue.token == '' || onValue.token.toString() == 'null') {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RouteNames.login);
      } else {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RouteNames.home);
      }
    }).onError((error, stackTrace) {});
  }
}
