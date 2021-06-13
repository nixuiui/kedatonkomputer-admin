import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_bloc.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_event.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_state.dart';
import 'package:kedatonkomputer/ui/screens/home_page.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/form.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var bloc = AuthBloc();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is AuthLoginSuccess) {
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomePage()
          ));
        } else if(state is AuthFailure) {
          setState(() {
            isLoading = false;
          });
          Toast.show(state.error, context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo.png", height: 60),
                SizedBox(height: 32),
                TitleText("KEDATON KOMPUTER"),
                SizedBox(height: 16),
                TitleText("LOGIN ADMIN"),
                SizedBox(height: 32),
                TextFieldBorderBottom(
                  textHint: "Username",
                  controller: usernameController,
                ),
                SizedBox(height: 16),
                TextFieldBorderBottom(
                  textHint: "Password",
                  controller: passwordController,
                  isObsecure: true,
                ),
                SizedBox(height: 16),
                RaisedButtonPrimary(
                  text: "Login",
                  isLoading: isLoading,
                  onPressed: isLoading ? null : () => login(),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  login() {
    if(usernameController.text == null || usernameController.text == "") 
      Toast.show("Username tidak boleh kosong", context);
    else if(passwordController.text == null || passwordController.text == "") 
      Toast.show("Password tidak boleh kosong", context);
    else {
      setState(() {
        isLoading = true;
      });
      bloc.add(Login(username: usernameController.text, password: passwordController.text));
    }
  }
}