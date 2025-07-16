import 'package:safar_khaneh_panel/core/network/auth_api_client.dart';
import 'package:safar_khaneh_panel/data/models/discount_model.dart';

class DiscountService {
  final AuthApiClient _client = AuthApiClient();

  Future<List<DiscountModel>> fetchDiscounts() async {
    try {
      final response = await _client.get('discounts/');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List data = response.data as List;
        return data.map((item) => DiscountModel.fromJson(item)).toList();
      } else {
        throw Exception('خطا در دریافت لیست تخفیف‌ها: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در دریافت لیست تخفیف‌ها: $e');
    }
  }

  Future<void> createDiscount({
    required String title,
    String? description,
    required String code,
    required int discountPercentage,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final response = await _client.post(
        'discounts/',
        data: {
          'title': title,
          'description': description,
          'code': code,
          'discount_percentage': discountPercentage,
          'start_date': startDate,
          'end_date': endDate,
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('خطا در افزودن تخفیف: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در افزودن تخفیف: $e');
    }
  }

  Future<void> deleteDiscount(int id) async {
    try {
      final response = await _client.delete('discounts/$id');

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception('حذف با خطا مواجه شد: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در حذف کد تخفیف: $e');
    }
  }
}
