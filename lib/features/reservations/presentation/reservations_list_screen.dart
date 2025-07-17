import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/convert_to_jalali.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/models/reservation_model.dart';
import 'package:safar_khaneh_panel/data/api/reservation_services.dart';

class ReservationsListScreen extends StatefulWidget {
  const ReservationsListScreen({super.key});

  @override
  State<ReservationsListScreen> createState() => _ReservationsListScreenState();
}

class _ReservationsListScreenState extends State<ReservationsListScreen> {
  final ReservationService _reservationService = ReservationService();
  late Future<List<ReservationModel>> _reservations;
  @override
  void initState() {
    super.initState();
    _reservations = _reservationService.fetchReservations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'لیست رزرو ها',
          style: TextStyle(color: AppColors.error300),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left, color: AppColors.error300),
            onPressed: () {
              context.pop();
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _reservations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('خطایی رخ داده است'));
          }
          final reservations = snapshot.data!;
          return ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              final reservation = reservations[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.error300,
                  child: Text(
                    formatNumberToPersian(reservation.id),
                    style: const TextStyle(color: AppColors.white),
                  ),
                ),
                title: Text(reservation.residence.title),
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      reservation.user.fullName,
                      style: const TextStyle(
                        color: AppColors.grey700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${formatNumberToPersianWithoutSeparator(convertToJalaliDate(reservation.checkIn))} - ${formatNumberToPersianWithoutSeparator(convertToJalaliDate(reservation.checkOut))}',
                      style: const TextStyle(
                        color: AppColors.grey500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(Iconsax.eye),
                onTap: () {
                  context.push(
                    '/reservation/${reservation.id}',
                    extra: reservation,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
