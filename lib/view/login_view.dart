import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/res/strings.dart';
import 'package:mvvm/utils/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocus,
                decoration: InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.alternate_email)),
                onFieldSubmitted: (value) {
                  Utils.fieldFocusNode(context, emailFocus, passwordFocus);
                },
              ),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                keyboardType: TextInputType.emailAddress,
                focusNode: passwordFocus,
                decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_open_rounded),
                    suffixIcon: Icon(Icons.visibility_off_rounded)),
              ),
              SizedBox(
                height: 25,
              ),
              RoundButton(
                  title: AppStrings.login,
                  onPress: () {
                    if (emailController.text.toString().isEmpty) {
                      Utils.flushBarErrorMessage("Please enter email", context);
                    } else if (passwordController.text.toString().isEmpty) {
                      Utils.flushBarErrorMessage(
                          "Please enter password", context);
                    } else if (passwordController.text.length < 6) {
                      Utils.flushBarErrorMessage(
                          "Please enter 6 digit password", context);
                    } else {
                      print("Api Hit");
                    }
                  }),
            ],
          ),
        ));
  }
}
