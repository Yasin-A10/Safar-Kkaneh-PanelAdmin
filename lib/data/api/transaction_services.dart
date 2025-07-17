import 'package:safar_khaneh_panel/core/network/auth_api_client.dart';
import 'package:safar_khaneh_panel/data/models/transaction_model.dart';

class TransactionService {
  final AuthApiClient _client = AuthApiClient();

  Future<List<TransactionModel>> fetchTransactions({
    String? query,
    String? status,
    String? type,
  }) async {
    try {
      final response = await _client.get('payments/', queryParams: {
        'q': query,
        'status': status,
        'type': type,
      });
      if (response.statusCode == 200) {
        final List data = response.data as List;
        return data.map((e) => TransactionModel.fromJson(e)).toList();
      } else {
        throw Exception('خطا در دریافت تراکنش‌ها');
      }
    } catch (e) {
      throw Exception('خطا: $e');
    }
  }
}
