import 'dart:io';
import 'package:dio/dio.dart';
import 'package:kedatonkomputer/core/api/main_api.dart';
import 'package:kedatonkomputer/core/models/order_model.dart';
import 'package:kedatonkomputer/core/models/report_model.dart';

class OrderApi extends MainApi {
  
  Future<OrderModel> detailOrder(String id) async {
    try {
      final response = await getRequest(
        url: "$host/admin/order/$id",
        useAuth: true
      );
      return orderModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<bool> confirmationOrder({
    String id,
    String cancelReason,
    String status
  }) async {
    try {
      await patchRequest(
        url: "$host/admin/confirmation-order/$id",
        useAuth: true,
        body: {
          "status" : status,
          "cancelReason" : cancelReason
        }
      );
      return true;
    } catch (error) {
      throw error;
    }
  }
  
  Future<bool> receiveOrder(String id, File proofItemReceived) async {
    try {
      var multiPartFile = await MultipartFile.fromFile(proofItemReceived.path);
      await postRequest(
        url: "$host/admin/item-received",
        useAuth: true,
        isFormData: true,
        body: FormData.fromMap({
          "proofItemReceived": multiPartFile,
          "order": id
        })
      );
      return true;
    } catch (error) {
      throw error;
    }
  }
  
  Future<List<OrderModel>> getOrders({
    String page = "1",
    String limit = "10",
    String status = ""
  }) async {
    try {
      final response = await getRequest(
        url: "$host/admin/order?page=$page&limit=$limit&status=$status",
        useAuth: true
      );
      return orderResponseFromJson(response).order;
    } catch (error) {
      throw error;
    }
  }
  
  Future<ReportResponse> report({
    String fromDate,
    String toDate
  }) async {
    try {
      final response = await getRequest(
        url: "$host/admin/report?fromDate=$fromDate&toDate=$toDate",
        useAuth: true
      );
      return reportResponseFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
}