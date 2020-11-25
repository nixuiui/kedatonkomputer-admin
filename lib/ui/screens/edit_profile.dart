import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_bloc.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_event.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_state.dart';
import 'package:kedatonkomputer/core/models/account_model.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';
import 'package:kedatonkomputer/ui/widget/form.dart';

class EditProfilePage extends StatefulWidget {

  const EditProfilePage({
    Key key,
    @required this.account,
  }) : super(key: key);
  
  final AccountModel account;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
  var bloc = AuthBloc();
  var isLoading = false;
  AccountModel account;

  @override
  void initState() {
    account = widget.account;
    nameController.text = account.fullName;
    emailController.text = account.email;
    phoneNumberController.text = account.phoneNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is ProfileUpdated) {
          setState(() {
            isLoading = false;
            account = state.data;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    Text("Nama"),
                    TextFieldBorderBottom(
                      textHint: "Nama",
                      controller: nameController,
                    ),
                    SizedBox(height: 16),
                    Text("Email"),
                    TextFieldBorderBottom(
                      textHint: "Email",
                      controller: emailController,
                    ),
                    SizedBox(height: 16),
                    Text("No Handphone"),
                    TextFieldBorderBottom(
                      textHint: "0812xxxxx",
                      controller: phoneNumberController,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: RaisedButtonAccent(
                  text: "Simpan",
                  isLoading: isLoading,
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                      account.fullName = nameController.text;
                      account.email = emailController.text;
                      account.phoneNumber = phoneNumberController.text;
                      bloc.add(UpdateProfile(
                        data: account
                      ));
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}