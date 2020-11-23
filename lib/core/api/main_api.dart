import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:kedatonkomputer/helper/shared_preferences.dart';

class MainApi {
  String host = 'https://kedaton-komputer.herokuapp.com';
  Dio dio = Dio();
  String get getHost => host;

  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader: ""
  };

  Future<String> postRequest({
    String url,
    Object body,
    bool useAuth = false,
    bool isFormData = false
  }) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) throw "no_internet";
    var apiToken = await SharedPreferencesHelper.getApiToken();
    if(useAuth)
      this.headers[HttpHeaders.authorizationHeader] = "Bearer $apiToken";
    print('REQUEST_POST: $url');
    print('REQUEST_HEADER: $headers');
    print('REQUEST_BODY: $body');
    try {
      final response = await dio.post<String>(
        url, 
        data: isFormData ? FormData.fromMap(body) : jsonEncode(body),
        options: Options(
          headers: this.headers,
          validateStatus: (status) => true,
          contentType: isFormData ? Headers.formUrlEncodedContentType : Headers.jsonContentType
        )
      );
      print("RESPONSE_CODE: " + response.statusCode.toString());
      print("RESPONSE_BODY: " + response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonEncode(jsonDecode(response.data)['data']);
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw jsonDecode(response.data)['message'];
      } else if (response.statusCode == 500) {
        throw "Server Error";
      } else {
        throw 'Failed to Load';
      }
    } catch (error) {
        throw error;
    }
  }
  
  Future<String> patchRequest({
    String url,
    dynamic body,
    bool useAuth = false,
    bool isFormData = false
  }) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) throw "no_internet";
    var apiToken = await SharedPreferencesHelper.getApiToken();
    if(useAuth)
      this.headers[HttpHeaders.authorizationHeader] = "Bearer $apiToken";
    print('REQUEST_PATCH: $url');
    print('REQUEST_HEADER: $headers');
    print('REQUEST_BODY: $body');
    try {
      final response = await dio.patch<String>(
        url,
        data: isFormData ? FormData.fromMap(body) : jsonEncode(body),
        options: Options(
          headers: this.headers,
          validateStatus: (status) => true,
          contentType: isFormData ? Headers.formUrlEncodedContentType : Headers.jsonContentType
        )
      );
      print("RESPONSE_CODE: " + response.statusCode.toString());
      print("RESPONSE_BODY: " + response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonEncode(jsonDecode(response.data)['data']);
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw jsonDecode(response.data)['message'];
      } else if (response.statusCode == 500) {
        throw "Server Error";
      } else {
        throw 'Failed to Load';
      }
    } catch (error) {
        throw error;
    }
  }

  Future<String> getRequest({
    String url,
    bool useAuth = false
  }) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) throw "no_internet";
    var apiToken = await SharedPreferencesHelper.getApiToken();
    if(useAuth) 
      this.headers[HttpHeaders.authorizationHeader] = "Bearer $apiToken";
    print('REQUEST_GET: $url');
    print('REQUEST_HEADER: $headers');
    try {
      final response = await dio.get<String>(
        url,
        options: Options(
          headers: this.headers,
          validateStatus: (status) => true
        )
      );
      print("RESPONSE_CODE: " + response.statusCode.toString());
      print("RESPONSE_BODY: " + response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonEncode(jsonDecode(response.data)['data']);
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw jsonDecode(response.data)['message'];
      } else if (response.statusCode == 500) {
        throw "Server Error";
      } else {
        throw 'Failed to Load';
      }
    } catch (error) {
        throw error;
    }
  }
  
  Future<String> deleteRequest({
    String url,
    bool useAuth = false
  }) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) throw "no_internet";
    var apiToken = await SharedPreferencesHelper.getApiToken();
    if(useAuth)
      this.headers[HttpHeaders.authorizationHeader] = "Bearer $apiToken";
    print('REQUEST_DELETE: $url');
    print('REQUEST_HEADER: $headers');
    try {
      final response = await dio.delete<String>(
        url,
        options: Options(
          headers: this.headers,
          validateStatus: (status) => true
        )
      );
      print("RESPONSE_CODE: " + response.statusCode.toString());
      print("RESPONSE_BODY: " + response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonEncode(jsonDecode(response.data)['data']);
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw jsonDecode(response.data)['message'];
      } else if (response.statusCode == 500) {
        throw "Server Error";
      } else {
        throw 'Failed to Load';
      }
    } catch (error) {
        throw error;
    }
  }
  
  Future<String> putRequest({
    String url,
    bool useAuth = false
  }) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) throw "no_internet";
    var apiToken = await SharedPreferencesHelper.getApiToken();
    if(useAuth)
      this.headers[HttpHeaders.authorizationHeader] = "Bearer $apiToken";
    print('REQUEST_PUT: $url');
    print('REQUEST_HEADER: $headers');
    try {
      final response = await dio.put<String>(
        url,
        options: Options(
          headers: this.headers,
          validateStatus: (status) => true
        )
      );
      print("RESPONSE_CODE: " + response.statusCode.toString());
      print("RESPONSE_BODY: " + response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonEncode(jsonDecode(response.data)['data']);
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw jsonDecode(response.data)['message'];
      } else if (response.statusCode == 500) {
        throw "Server Error";
      } else {
        throw 'Failed to Load';
      }
    } catch (error) {
        throw error;
    }
  }
}