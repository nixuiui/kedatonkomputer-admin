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
  
  Future<bool> createProduct({ProductPost data}) async {
    try {
      await postRequest(
        url: "$host/admin/product",
        useAuth: true,
        body: data.toMap(),
        isFormData: true
      );
      return true;
    } catch (error) {
      throw error;
    }
  }
  
  Future<bool> editProduct({ProductPost data}) async {
    try {
      await patchRequest(
        url: "$host/admin/product/${data.id}",
        useAuth: true,
        isFormData: true,
        body: data.toMap()
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