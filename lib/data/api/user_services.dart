import 'package:safar_khaneh_panel/core/network/auth_api_client.dart';
import 'package:safar_khaneh_panel/data/models/user_model.dart';

class UserService {
  final AuthApiClient _client = AuthApiClient();

  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await _client.get('users/');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List data = response.data as List;
        return data.map((item) => UserModel.fromJson(item)).toList();
      } else {
        throw Exception('خطا در دریافت کاربران: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در دریافت کاربران: $e');
    }
  }

  Future<void> updateUser({
    required int id,
    required bool isActive,
    required bool isAdmin,
    required String phoneNumber,
    required String fullName,
  }) async {
    try {
      final response = await _client.put(
        'users/$id/',
        data: {
          "is_active": isActive,
          "is_admin": isAdmin,
          "phone_number": phoneNumber,
          "full_name": fullName,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        throw Exception('خطا در بروزرسانی کاربر: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در بروزرسانی کاربر: $e');
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      final response = await _client.delete('users/$id/');

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception('خطا در حذف کاربر: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در حذف کاربر: $e');
    }
  }
}
