import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_bloc.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_event.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_state.dart';
import 'package:kedatonkomputer/core/models/account_model.dart';
import 'package:kedatonkomputer/ui/screens/home_page.dart';
import 'package:kedatonkomputer/ui/screens/login.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/form.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';
import 'package:toast/toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
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
        } else if(state is RegisterSuccess) {
          bloc.add(Login(username: emailController.text, password: passwordController.text));
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
                TitleText("REGISTER"),
                SizedBox(height: 32),
                TextFieldBorderBottom(
                  textHint: "Nama",
                  controller: nameController,
                ),
                SizedBox(height: 16),
                TextFieldBorderBottom(
                  textHint: "Email",
                  controller: emailController,
                ),
                SizedBox(height: 16),
                TextFieldBorderBottom(
                  textHint: "Phone Number",
                  controller: phoneNumberController,
                ),
                SizedBox(height: 16),
                TextFieldBorderBottom(
                  textHint: "Password",
                  controller: passwordController,
                  isObsecure: true,
                ),
                SizedBox(height: 16),
                RaisedButtonPrimary(
                  text: "Daftar",
                  isLoading: isLoading,
                  onPressed: isLoading ? null : () {
                    setState(() {
                      isLoading = true;
                    });
                    bloc.add(Register(data: AccountModel(
                      fullName: nameController.text,
                      email: emailController.text,
                      phoneNumber: phoneNumberController.text,
                      password: passwordController.text,
                    )));
                  },
                ),
                SizedBox(height: 32),
                FlatButton(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => LoginPage()
                  )), 
                  child: Text("Login")
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}