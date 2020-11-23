import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_bloc.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_event.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_state.dart';
import 'package:kedatonkomputer/ui/screens/home_page.dart';
import 'package:kedatonkomputer/ui/screens/login.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final bloc = AuthBloc();

  @override
  void initState() {
    bloc.add(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is AuthUnauthenticated) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
        else if(state is AuthAuthenticated) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.jpeg", height: 100),
              SizedBox(height: 32),
              TitleText("KEDATON KOMPUTER"),
            ],
          )
        )
      ),
    );
  }
}
