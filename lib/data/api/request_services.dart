import 'package:safar_khaneh_panel/core/network/auth_api_client.dart';
import 'package:safar_khaneh_panel/data/models/residence_model.dart';

class RequestServices {
  final AuthApiClient _client = AuthApiClient();

  Future<List<ResidenceModel>> fetchPendingResidences() async {
    try {
      final response = await _client.get('residences/pending/');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List data = response.data as List;
        return data.map((item) => ResidenceModel.fromJson(item)).toList();
      } else {
        throw Exception('خطا در دریافت اقامتگاه‌ها: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در دریافت اقامتگاه‌ها: $e');
    }
  }

  Future<void> updatePendingResidence({required int id}) async {
    try {
      final response = await _client.put('residences/pending/$id');

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('خطا در ویرایش اقامتگاه');
      }
    } catch (e) {
      throw Exception('خطای ارتباط با سرور: $e');
    }
  }

  Future<void> deletePendingResidence(int id) async {
    try {
      final response = await _client.delete('residences/pending/$id');

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception('خطا در حذف اقامتگاه: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در حذف اقامتگاه: $e');
    }
  }
}
