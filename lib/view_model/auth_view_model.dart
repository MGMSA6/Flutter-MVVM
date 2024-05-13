import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/routes/route_names.dart';
import 'package:mvvm/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _authRepo = AuthRepository();

  bool _loading = false;

  bool get loading => _loading;

  bool _signUpLoading = false;

  bool get signUpLoading => _signUpLoading;

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _authRepo.loginApi(data).then((value) {
      setLoading(false);
      Utils.showSnackBar("$value", context);
      if (kDebugMode) {
        print("Login Response: $value");
        Navigator.pushNamed(context, RouteNames.home);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage("$error", context);
      if (kDebugMode) {
        print("$error");
      }
    });
  }

  Future<void> registerApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _authRepo.registerApi(data).then((value) {
      setSignUpLoading(false);
      Utils.showSnackBar("$value", context);
      if (kDebugMode) {
        Navigator.pushNamed(context, RouteNames.login);
        print("Register Response: $value");
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage("$error", context);
      if (kDebugMode) {
        print("$error");
      }
    });
  }
}
