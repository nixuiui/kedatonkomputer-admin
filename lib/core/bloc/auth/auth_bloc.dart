import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kedatonkomputer/core/api/auth_api.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_event.dart';
import 'package:kedatonkomputer/core/bloc/auth/auth_state.dart';
import 'package:kedatonkomputer/core/models/account_model.dart';
import 'package:kedatonkomputer/helper/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final api = AuthApi();

  AuthBloc() : super(AuthUninitialized());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {

    if (event is AppStarted) {
      final isAuthenticated = await SharedPreferencesHelper.isAuthenticated();
      await Future.delayed(Duration(seconds: 3));
      if (isAuthenticated) {
        String json = await SharedPreferencesHelper.getAccount();
        var account = accountModelFromMap(json);
        yield AuthAuthenticated(data: account);
      } else {
        yield AuthUnauthenticated();
      }
    }
    
    if (event is Login) {
      yield AuthLoading();
      try {
        final response = await api.login(username: event.username, password: event.password);
        SharedPreferencesHelper.setApiToken(response.token);
        SharedPreferencesHelper.setAccount(jsonEncode(response.toMap()));
        SharedPreferencesHelper.setAuthenticated(true);
        FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
        _firebaseMessaging.subscribeToTopic("admin");
        yield AuthLoginSuccess(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield AuthFailure(error: error.toString());
      }
    }
    
    if (event is LoadProfileInfo) {
      yield AuthLoading();
      try {
        var response = await api.getProfile();
        yield ProfileInfoLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield AuthFailure(error: error.toString());
      }
    }
    
    if (event is UpdateProfile) {
      yield AuthLoading();
      try {
        var response = await api.editProfile(data: event.data);
        yield ProfileUpdated(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield AuthFailure(error: error.toString());
      }
    }
    
    if (event is Logout) {
      yield AuthLoading();
      FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
        _firebaseMessaging.unsubscribeFromTopic("admin");
      SharedPreferencesHelper.clear();
      yield AuthUnauthenticated();
    }

  }
}