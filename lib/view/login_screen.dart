import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/route_names.dart';
import 'package:mvvm/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: InkWell(
          onTap: () {
            Utils.showSnackBar("No Internet Connection", context);
            //Utils.flushBarErrorMessage("No Internet Connection", context);
            //Utils.toastMessage("No Internet Connection");
            //Navigator.pushNamed(context, RouteNames.home);
          },
          child: Text("Click")),
    ));
  }
}
