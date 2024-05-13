import 'package:flutter/material.dart';
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
        body: SafeArea(
      child: Column(
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
          )
        ],
      ),
    ));
  }
}
