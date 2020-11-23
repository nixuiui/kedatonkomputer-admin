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
  
  Future<Product> createProduct({ProductPost data}) async {
    try {
      final response = await postRequest(
        url: "$host/admin/product",
        useAuth: true,
        body: data.toMap()
      );
      return productFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<Product> editProduct({ProductPost data}) async {
    try {
      final response = await postRequest(
        url: "$host/admin/product/${data.id}",
        useAuth: true,
        body: data.toMap()
      );
      return productFromMap(response);
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