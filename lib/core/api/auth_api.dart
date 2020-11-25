import 'package:flutter/material.dart';
import 'package:kedatonkomputer/core/api/main_api.dart';
import 'package:kedatonkomputer/core/models/account_model.dart';

class AuthApi extends MainApi {
  
  Future<AccountModel> login({
    @required String username,
    @required String password
  }) async {
    try {
      final response = await postRequest(
        url: "$host/admin/login",
        body: {
          "email": username,
          "password": password
        }
      );
      return accountModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<AccountModel> getProfile() async {
    try {
      final response = await getRequest(
        url: "$host/admin/me",
        useAuth: true
      );
      return accountModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<AccountModel> editProfile({
    @required AccountModel data
  }) async {
    try {
      final response = await patchRequest(
        url: "$host/admin/update",
        body: data.toEditAccountMap(),
        useAuth: true
      );
      return accountModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  // Future<AccountModel> editPassword({
  //   @required String password,
  //   @required String oldPassword
  // }) async {
  //   try {
  //     final response = await patchRequest(
  //       url: "$host/admin/me/password",
  //       body: {
  //         "password" : password,
  //         "oldPassword" : oldPassword
  //       },
  //       useAuth: true
  //     );
  //     return accountModelFromMap(response);
  //   } catch (error) {
  //     throw error;
  //   }
  // }
  
}