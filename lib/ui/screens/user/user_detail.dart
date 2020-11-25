import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedatonkomputer/core/bloc/user/user_bloc.dart';
import 'package:kedatonkomputer/core/bloc/user/user_event.dart';
import 'package:kedatonkomputer/core/bloc/user/user_state.dart';
import 'package:kedatonkomputer/core/models/user_model.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';
import 'package:toast/toast.dart';

class UserDetailPage extends StatefulWidget {

  const UserDetailPage({
    Key key,
    this.user,
  }) : super(key: key);
  
  final User user;

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {

  var bloc = UserBloc();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is UserPasswordWasReset) {
          Toast.show("Berhasil reset password", context);
          setState(() {
            isLoading = false;
          });
        } else if(state is UserFailure) {
          Toast.show(state.error, context);
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detail User"),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            LabelText("Nama"),
            TextCustom(widget.user.name),
            SizedBox(height: 16),
            LabelText("Email"),
            TextCustom(widget.user.email),
            SizedBox(height: 16),
            LabelText("No Hp"),
            TextCustom(widget.user.phoneNumber),
            SizedBox(height: 16),
            LabelText("Kelamin"),
            TextCustom(widget.user.gender == "L" ? "Laki-laki" : "Perempuan"),
            SizedBox(height: 32),
            RaisedButtonCustom(
              text: "Reset Password",
              isLoading: isLoading,
              onPressed: () {
                setState(() {
                  isLoading = true;
                  bloc.add(ResetPassword(id: widget.user.id));
                });
              }
            )
          ],
        ),
      ),
    );
  }
}