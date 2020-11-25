import 'package:kedatonkomputer/core/api/main_api.dart';
import 'package:kedatonkomputer/core/models/user_model.dart';

class UserApi extends MainApi {

  Future<List<User>> loadUsers({
    int page = 1,
    int limit = 10,
    String search = ""
  }) async {
    try {
      final response = await getRequest(
        url: "$host/admin/user?page=1&limit=10&search=",
        useAuth: true
      );
      return userResponseFromMap(response).user;
    } catch (error) {
      throw error;
    }
  }

  Future<User> loadUserDetail({String id}) async {
    try {
      final response = await getRequest(
        url: "$host/admin/user/$id",
        useAuth: true
      );
      return userFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<bool> deleteUser({String id}) async {
    try {
      await deleteRequest(
        url: "$host/admin/user/$id",
        useAuth: true
      );
      return true;
    } catch (error) {
      throw error;
    }
  }
  
  Future<bool> resetPassword({String id}) async {
    try {
      await patchRequest(
        url: "$host/admin/user/$id",
        useAuth: true
      );
      return true;
    } catch (error) {
      throw error;
    }
  }
  
}