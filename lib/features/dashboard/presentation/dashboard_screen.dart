import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/api/chart_service.dart';
import 'package:safar_khaneh_panel/data/api/reservation_services.dart';
import 'package:safar_khaneh_panel/data/api/residence_services.dart';
import 'package:safar_khaneh_panel/data/api/user_services.dart';
import 'package:safar_khaneh_panel/data/models/chart_model.dart';
import 'package:safar_khaneh_panel/data/models/reservation_model.dart';
import 'package:safar_khaneh_panel/data/models/residence_model.dart';
import 'package:safar_khaneh_panel/data/models/user_model.dart';
import 'package:safar_khaneh_panel/widgets/bar_chart.dart';
import 'package:safar_khaneh_panel/widgets/cards/show_number_card.dart';

final List<int> reservations = [100, 46, 20, 12, 56, 78, 12];

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ReservationService _reservationService = ReservationService();
  final UserService _userService = UserService();
  final ResidenceServices _residenceService = ResidenceServices();
  final ChartService _chartService = ChartService();
  late Future<List<ReservationModel>> _reservations;
  late Future<List<UserModel>> _users;
  late Future<List<ResidenceModel>> _residences;
  late Future<List<ChartModel>> _chartData;

  @override
  void initState() {
    super.initState();
    _reservations = _reservationService.fetchReservations();
    _users = _userService.fetchUsers();
    _residences = _residenceService.fetchConfirmedResidences();
    _chartData = _chartService.getChartData();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _reservations = _reservationService.fetchReservations();
      _users = _userService.fetchUsers();
      _residences = _residenceService.fetchConfirmedResidences();
      _chartData = _chartService.getChartData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                    future: _users,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text('خطایی رخ داده است'));
                      }
                      final users = snapshot.data!;
                      return ShowNumberCard(
                        title: 'تعداد کاربران',
                        icon: Iconsax.profile_2user5,
                        number: formatNumberToPersian(users.length),
                        color: AppColors.error300,
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  FutureBuilder(
                    future: _residences,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text('خطایی رخ داده است'));
                      }
                      final residences = snapshot.data!;
                      return ShowNumberCard(
                        title: 'تعداد اقامتگاه',
                        icon: Iconsax.house5,
                        number: formatNumberToPersian(residences.length),
                        color: AppColors.secondary500,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                    future: _reservations,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text('خطایی رخ داده است'));
                      }
                      final reservations = snapshot.data!;
                      return ShowNumberCard(
                        title: 'تعداد رزروها',
                        icon: Iconsax.archive_tick,
                        number: formatNumberToPersian(reservations.length),
                        color: AppColors.warning150,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 48),
              Column(
                children: [
                  Text(
                    'تعداد رزروهای هفته جاری',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder(
                    future: _chartData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text('خطایی رخ داده است'));
                      }
                      if (snapshot.data!.isEmpty) {
                        return const Center(child: Text('داده ای وجود ندارد'));
                      }
                      final chartData = snapshot.data!;
                      return BarChartWidget(reservations: chartData);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
