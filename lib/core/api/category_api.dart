import 'package:kedatonkomputer/core/api/main_api.dart';
import 'package:kedatonkomputer/core/models/category_model.dart';

class CategoryApi extends MainApi {
  
  Future<List<Category>> loadCategory() async {
    try {
      final response = await getRequest(
        url: "$host/admin/category",
        useAuth: true
      );
      return categoryResponseModelFromMap(response).category;
    } catch (error) {
      throw error;
    }
  }
  
  Future<bool> createCategory(String name) async {
    try {
      await postRequest(
        url: "$host/admin/category",
        useAuth: true,
        body: {"name": name}
      );
      return true;
    } catch (error) {
      throw error;
    }
  }
  
  Future<bool> editCategory(String name, String id) async {
    try {
      await patchRequest(
        url: "$host/admin/category/$id",
        useAuth: true,
        body: {"name": name}
      );
      return true;
    } catch (error) {
      throw error;
    }
  }
  
  Future<bool> deleteCategory(String id) async {
    try {
      await deleteRequest(
        url: "$host/admin/category/$id",
        useAuth: true
      );
      return true;
    } catch (error) {
      throw error;
    }
  }
  
}