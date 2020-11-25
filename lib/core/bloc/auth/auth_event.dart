import 'package:kedatonkomputer/core/models/account_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoadProfileInfo extends AuthEvent {}

class Login extends AuthEvent {
  final String username;
  final String password;

  const Login({
    @required this.username,
    @required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class Register extends AuthEvent {
  final AccountModel data;

  const Register({
    @required this.data,
  });

  @override
  List<Object> get props => [data];
}

class CheckAccount extends AuthEvent {
  final String username;
  final String email;
  final String phoneNumber;

  const CheckAccount({
    this.username,
    this.email,
    this.phoneNumber,
  });

  @override
  List<Object> get props => [username, email, phoneNumber];
}

class UpdateProfile extends AuthEvent {
  final AccountModel data;

  const UpdateProfile({
    this.data,
  });

  @override
  List<Object> get props => [data];
}

class Logout extends AuthEvent {}