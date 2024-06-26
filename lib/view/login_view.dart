import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/res/strings.dart';
import 'package:mvvm/utils/routes/route_names.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier(true);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _obsecurePassword.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocus.dispose();
    passwordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authViewModel = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
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
              ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      obscureText: value,
                      controller: _passwordController,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: passwordFocus,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_open_rounded),
                          suffixIcon: InkWell(
                              onTap: () {
                                _obsecurePassword.value =
                                    !_obsecurePassword.value;
                              },
                              child: value
                                  ? Icon(Icons.visibility_off_rounded)
                                  : Icon(Icons.visibility))),
                    );
                  }),
              SizedBox(
                height: height * .085,
              ),
              RoundButton(
                  title: AppStrings.login,
                  loading: _authViewModel.loading,
                  onPress: () {
                    if (_emailController.text.toString().isEmpty) {
                      Utils.flushBarErrorMessage("Please enter email", context);
                    } else if (_passwordController.text.toString().isEmpty) {
                      Utils.flushBarErrorMessage(
                          "Please enter password", context);
                    } else if (_passwordController.text.length < 6) {
                      Utils.flushBarErrorMessage(
                          "Please enter 6 digit password", context);
                    } else {
                      Map data = {
                        'email': _emailController.text.toString(),
                        'password': _passwordController.text.toString()
                      };
                      _authViewModel.loginApi(data, context);
                      print("Api Hit");
                    }
                  }),
              SizedBox(
                height: height * .02,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.signUp);
                },
                child: Text("Don't have an account? SignUp"),
              )
            ],
          ),
        ));
  }
}
