import 'package:safar_khaneh_panel/core/network/auth_api_client.dart';
import 'package:safar_khaneh_panel/data/models/chart_model.dart';

class ChartService {
  final AuthApiClient _client = AuthApiClient();

  ChartService();

  Future<List<ChartModel>> getChartData() async {
    final response = await _client.get('dashboard/reservation-weekly-chart/');

    final List<dynamic> data = response.data;

    return data.map((json) => ChartModel.fromJson(json)).toList();
  }
}
