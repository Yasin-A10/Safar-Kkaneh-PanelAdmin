import 'package:safar_khaneh_panel/core/network/auth_api_client.dart';
import 'package:safar_khaneh_panel/data/models/comment_model.dart';

class CommentServices {
  final AuthApiClient _client = AuthApiClient();

  Future<List<CommentModel>> fetchComments({String? query}) async {
    try {
      final response = await _client.get('reviews/', queryParams: {'q': query});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List data = response.data as List;
        return data.map((item) => CommentModel.fromJson(item)).toList();
      } else {
        throw Exception('خطا در دریافت اقامتگاه‌ها: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در دریافت اقامتگاه‌ها: $e');
    }
  }

  Future<void> updateComment(int id, String comment) async {
    try {
      final response = await _client.put(
        'reviews/$id/',
        data: {'comment': comment},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        throw Exception('خطا در بروزرسانی اقامتگاه: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در بروزرسانی اقامتگاه: $e');
    }
  }

  Future<void> deleteComment(int id) async {
    try {
      final response = await _client.delete('reviews/$id/');

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception('خطا در حذف نظر: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطا در حذف نظر: $e');
    }
  }
}
