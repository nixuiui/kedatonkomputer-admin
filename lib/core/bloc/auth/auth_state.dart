import 'package:equatable/equatable.dart';
import 'package:kedatonkomputer/core/models/account_model.dart';
import 'package:meta/meta.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthUninitialized extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class AuthChecking extends AuthState {}

class AuthAuthenticated extends AuthState {
  final AccountModel data;

  const AuthAuthenticated({@required this.data});

  @override
  List<Object> get props => [data];
}

class ProfileInfoLoaded extends AuthState {
  final AccountModel data;

  const ProfileInfoLoaded({@required this.data});

  @override
  List<Object> get props => [data];
}

class AuthLoginSuccess extends AuthState {
  final AccountModel data;

  const AuthLoginSuccess({@required this.data});

  @override
  List<Object> get props => [data];
}

class RegisterSuccess extends AuthState {}

class AccountAvailable extends AuthState {
  final String data;

  const AccountAvailable({@required this.data});

  @override
  List<Object> get props => [data];
}

class ProfileUpdated extends AuthState {
  final AccountModel data;

  const ProfileUpdated({@required this.data});

  @override
  List<Object> get props => [data];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
