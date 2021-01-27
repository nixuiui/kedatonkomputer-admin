import 'package:dio/dio.dart';
import 'package:kedatonkomputer/core/api/main_api.dart';
import 'package:kedatonkomputer/core/models/product_model.dart';

class ProductApi extends MainApi {

  Future<List<Product>> loadProducts({
    int page = 1,
    int limit = 10,
    String search = ""
  }) async {
    try {
      final response = await getRequest(
        url: "$host/admin/product?page=$page&limit=$limit&search=$search",
        useAuth: true
      );
      return productResponseModelFromMap(response).product;
    } catch (error) {
      throw error;
    }
  }

  Future<Product> loadProductDetail({String id}) async {
    try {
      final response = await postRequest(
        url: "$host/admin/product/$id",
        useAuth: true
      );
      return productFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<bool> uploadImageProduct({MultipartFile file, String id}) async {
    try {
      await postRequest(
        url: "$host/admin/image-product/$id",
        useAuth: true,
        body: {
            "photo": file
        },
        isFormData: true
      );
      return true;
    } catch (error) {
      throw error;
    }
  }

  Future<Product> createProduct({ProductPost data}) async {
    try {
      var formData = FormData();
      for (var item in data.photo) {
        formData.files.add(MapEntry('photo', item));
      }
      formData.fields.addAll([
        MapEntry('name', data.name),
        MapEntry('merkProduct', data.merkProduct),
        MapEntry('buyPrice', data.buyPrice),
        MapEntry('sellPrice', data.sellPrice),
        MapEntry('description', data.description),
        MapEntry('category', data.category),
        MapEntry('stock', data.stock),
      ]);
      var response = await postRequest(
        url: "$host/admin/product",
        useAuth: true,
        body: formData,
        isFormData: true
      );
      return productFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<bool> editProduct({ProductPost data}) async {
    try {
      var formData = FormData();
      for (var item in data.photo) {
        formData.files.add(MapEntry('photo', item));
      }
      formData.fields.addAll([
        MapEntry('name', data.name),
        MapEntry('merkProduct', data.merkProduct),
        MapEntry('buyPrice', data.buyPrice),
        MapEntry('sellPrice', data.sellPrice),
        MapEntry('description', data.description),
        MapEntry('category', data.category),
        MapEntry('stock', data.stock),
      ]);
      await patchRequest(
        url: "$host/admin/product/${data.id}",
        useAuth: true,
        isFormData: true,
        body: formData,
      );
      return true;
    } catch (error) {
      throw error;
    }
  }
  
  Future<bool> deleteProduct({String id}) async {
    try {
      await deleteRequest(
        url: "$host/admin/product/$id",
        useAuth: true
      );
      return true;
    } catch (error) {
      throw error;
    }
  }
  
}