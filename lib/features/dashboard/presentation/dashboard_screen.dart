import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/widgets/bar_chart.dart';
import 'package:safar_khaneh_panel/widgets/cards/show_number_card.dart';

final List<int> reservations = [100, 46, 20, 12, 56, 78, 12];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShowNumberCard(
                  title: 'تعداد کاربران',
                  icon: Iconsax.profile_2user5,
                  number: formatNumberToPersian(100),
                  color: AppColors.error300,
                ),
                const SizedBox(width: 16),
                ShowNumberCard(
                  title: 'تعداد اقامتگاه',
                  icon: Iconsax.house5,
                  number: formatNumberToPersian(100),
                  color: AppColors.secondary500,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShowNumberCard(
                  title: 'تعداد رزروها',
                  icon: Iconsax.archive_tick,
                  number: formatNumberToPersian(100),
                  color: AppColors.warning150,
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
                BarChartWidget(reservations: reservations),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
