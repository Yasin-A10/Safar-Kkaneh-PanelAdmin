// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class BarChartWidget extends StatelessWidget {
//   final List<int> reservations = [3, 5, 2, 6, 1, 4, 7]; // شنبه تا جمعه

//   BarChartWidget({super.key});

//   final List<String> weekDays = ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'];

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.5,
//       child: BarChart(
//         BarChartData(
//           alignment: BarChartAlignment.spaceAround,
//           maxY: 8,
//           barTouchData: BarTouchData(enabled: false),
//           titlesData: FlTitlesData(
//             leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
//             rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (double value, TitleMeta meta) {
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 6.0),
//                     child: Text(
//                       weekDays[value.toInt()],
//                       style: const TextStyle(fontSize: 12),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           gridData: FlGridData(show: true),
//           borderData: FlBorderData(show: false),
//           barGroups: List.generate(reservations.length, (index) {
//             return BarChartGroupData(
//               x: index,
//               barRods: [
//                 BarChartRodData(
//                   toY: reservations[index].toDouble(),
//                   width: 20,
//                   borderRadius: BorderRadius.circular(4),
//                   color: Colors.indigo,
//                 ),
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }

// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:flutter/material.dart';

// // class BarChartWidget extends StatelessWidget {
// //   // داده‌های نمونه برای تعداد رزروها در هر روز هفته
// //   final Map<String, int> reservationData = {
// //     'شنبه': 5,
// //     'یک‌شنبه': 8,
// //     'دوشنبه': 3,
// //     'سه‌شنبه': 6,
// //     'چهارشنبه': 4,
// //     'پنج‌شنبه': 7,
// //     'جمعه': 2,
// //   };

// //   BarChartWidget({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Directionality(
// //       textDirection: TextDirection.rtl,
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text(
// //               'تعداد رزروها در هفته',
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 16),
// //             SizedBox(
// //               height: 300,
// //               child: BarChart(
// //                 BarChartData(
// //                   alignment: BarChartAlignment.spaceAround,
// //                   maxY:
// //                       10, // حداکثر مقدار محور Y (می‌تونید بر اساس داده‌ها تنظیم کنید)
// //                   barTouchData: BarTouchData(enabled: true),
// //                   titlesData: FlTitlesData(
// //                     show: true,
// //                     rightTitles: const AxisTitles(
// //                       sideTitles: SideTitles(showTitles: false),
// //                     ),
// //                     topTitles: const AxisTitles(
// //                       sideTitles: SideTitles(showTitles: false),
// //                     ),
// //                     bottomTitles: AxisTitles(
// //                       sideTitles: SideTitles(
// //                         showTitles: true,
// //                         getTitlesWidget: (value, meta) {
// //                           final dayIndex = value.toInt();
// //                           const days = [
// //                             'شنبه',
// //                             'یک‌شنبه',
// //                             'دوشنبه',
// //                             'سه‌شنبه',
// //                             'چهارشنبه',
// //                             'پنج‌شنبه',
// //                             'جمعه',
// //                           ];
// //                           return dayIndex >= 0 && dayIndex < days.length
// //                               ? Text(
// //                                   days[dayIndex],
// //                                   style: const TextStyle(fontSize: 12),
// //                                 )
// //                               : const Text('');
// //                         },
// //                         reservedSize: 40,
// //                       ),
// //                     ),
// //                     leftTitles: AxisTitles(
// //                       sideTitles: SideTitles(
// //                         showTitles: true,
// //                         reservedSize: 40,
// //                         getTitlesWidget: (value, meta) {
// //                           return Text(
// //                             value.toInt().toString(),
// //                             style: const TextStyle(fontSize: 12),
// //                           );
// //                         },
// //                       ),
// //                     ),
// //                   ),
// //                   gridData: const FlGridData(show: true),
// //                   borderData: FlBorderData(show: true),
// //                   barGroups: reservationData.entries.map((entry) {
// //                     final dayIndex = reservationData.keys.toList().indexOf(
// //                       entry.key,
// //                     );
// //                     return BarChartGroupData(
// //                       x: dayIndex,
// //                       barRods: [
// //                         BarChartRodData(
// //                           toY: entry.value.toDouble(),
// //                           color: Colors.blue,
// //                           width: 20,
// //                           borderRadius: BorderRadius.circular(4),
// //                         ),
// //                       ],
// //                     );
// //                   }).toList(),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';

class BarChartWidget extends StatelessWidget {
  final List<int> reservations;
  final List<String> weekDays = ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'];

  BarChartWidget({super.key, required this.reservations});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) {
                return AppColors.accentColor2;
              },
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  'تعداد رزرو: ${rod.toY.toInt()}',
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
                      weekDays[value.toInt()],
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
          barGroups: List.generate(reservations.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: reservations[index].toDouble(),
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
