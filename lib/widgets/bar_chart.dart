import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/models/chart_model.dart';

class BarChartWidget extends StatelessWidget {
  final List<ChartModel> reservations;

  BarChartWidget({super.key, required this.reservations})
    : assert(reservations.length == 7, 'تعداد رزروها باید ۷ عدد باشد.');

  final List<String> weekDays = ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'];

  List<T> rotateList<T>(List<T> list, int rotateBy) {
    return [...list.sublist(rotateBy), ...list.sublist(0, rotateBy)];
  }

  int getTodayIndex() {
    final now = DateTime.now();
    final int gregorianWeekday = now.weekday;
    switch (gregorianWeekday) {
      case 1:
        return 1;
      case 2:
        return 2;
      case 3:
        return 3;
      case 4:
        return 4;
      case 5:
        return 5;
      case 6:
        return 6;
      case 7:
        return 0;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final todayIndex = getTodayIndex();

    // چرخاندن آرایه‌ها طوری که امروز آخر باشد
    final rotatedWeekDays = rotateList(weekDays, todayIndex + 1);
    final rotatedReservations = rotateList(reservations, todayIndex + 1);

    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => AppColors.accentColor2,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  'تعداد رزرو: ${formatNumberToPersian(rod.toY.toInt())}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      rotatedWeekDays[value.toInt()],
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(rotatedReservations.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: rotatedReservations[index].count.toDouble(),
                  width: 20,
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.indigo,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
