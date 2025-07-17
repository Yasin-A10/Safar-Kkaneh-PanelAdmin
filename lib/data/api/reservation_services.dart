import 'package:safar_khaneh_panel/core/network/auth_api_client.dart';
import 'package:safar_khaneh_panel/data/models/reservation_model.dart';

class ReservationService {
  final AuthApiClient _client = AuthApiClient();

  Future<List<ReservationModel>> fetchReservations() async {
    try {
      final response = await _client.get('reservation');

      if (response.statusCode == 200) {
        final List data = response.data as List;
        return data.map((json) => ReservationModel.fromJson(json)).toList();
      } else {
        throw Exception('خطا در دریافت لیست رزروها: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در دریافت لیست رزروها: $e');
    }
  }

  Future<void> cancelReservation(int id) async {
    try {
      final response = await _client.post('reservation/$id/cancel/');
      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception('خطا در لغو رزرو: ${response.statusCode}');
      } else {
        return;
      }
    } catch (e) {
      throw Exception('خطا در لغو رزرو: $e');
    }
  }
}
