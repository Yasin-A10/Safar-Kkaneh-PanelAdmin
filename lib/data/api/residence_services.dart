import 'dart:io';
import 'package:dio/dio.dart';
import 'package:safar_khaneh_panel/core/network/auth_api_client.dart';
import 'package:safar_khaneh_panel/data/models/residence_model.dart';

class ResidenceServices {
  final AuthApiClient _client = AuthApiClient();

  Future<List<ResidenceModel>> fetchConfirmedResidences() async {
    try {
      final response = await _client.get('residences/confirmed/');

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

  Future<void> updateResidence({
    required int id,
    required String title,
    required String description,
    required String type,
    required int capacity,
    required int maxNightsStay,
    required int pricePerNight,
    required int cleaningPrice,
    required int servicesPrice,
    required int roomCount,
    required String address,
    required String lat,
    required String lng,
    required int cityId,
    required bool isActive,
    required List<int> featureIds,
    File? imageFile,
  }) async {
    try {
      final formData = FormData.fromMap({
        'title': title,
        'description': description,
        'type': type,
        'capacity': capacity,
        'max_nights_stay': maxNightsStay,
        'price_per_night': pricePerNight,
        'cleaning_price': cleaningPrice,
        'services_price': servicesPrice,
        'room_count': roomCount,
        'address': address,
        'lat': lat,
        'lng': lng,
        'city_id': cityId,
        'is_active': isActive,
        'feature_ids': featureIds,
        if (imageFile != null)
          'image': await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
      });

      final response = await _client.put(
        'residences/confirmed/$id/',
        data: formData,
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('خطا در ویرایش اقامتگاه');
      }
    } catch (e) {
      throw Exception('خطای ارتباط با سرور: $e');
    }
  }

  Future<void> deleteResidence(int id) async {
    try {
      final response = await _client.delete('residences/confirmed/$id/');

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception('خطا در حذف اقامتگاه: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در حذف اقامتگاه: $e');
    }
  }
}
