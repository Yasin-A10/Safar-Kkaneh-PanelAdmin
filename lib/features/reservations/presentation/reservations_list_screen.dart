import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/models/reservation_model.dart';

final List<ReservationModel> reservations = [
  ReservationModel(
    id: 1,
    title: 'ویلا کوهستانی',
    city: 'تهران',
    province: 'تهران',
    startDate: '1404/06/01',
    endDate: '1404/06/10',
    price: 100000,
    capacity: 4,
    roomCount: 2,
    managerName: 'میلادی',
    managerPhoneNumber: 0912345678,
    guestCount: 2,
    booker: 'محمد حسینی',
    cleaningFee: 10000,
    serviceFee: 5000,
    totalFee: 115000,
    bookerPhoneNumber: 0912345678,
    bookerEmail: 'mohammadhossein@gmail.com',
    transactions: [
      TransactionModel(
        transactionId: '123456781',
        transactionStatus: false,
        transactionFee: 115000,
        createdAt: '1404/06/01',
      ),
      TransactionModel(
        transactionId: '123456783',
        transactionStatus: false,
        transactionFee: 115000,
        createdAt: '1404/06/01',
      ),
      TransactionModel(
        transactionId: '123456782',
        transactionStatus: true,
        transactionFee: 115000,
        createdAt: '1404/06/01',
      ),
    ],
  ),
  ReservationModel(
    id: 2,
    title: 'ویلا کویری',
    city: 'تهران',
    province: 'تهران',
    startDate: '1404/06/01',
    endDate: '1404/06/10',
    price: 200000,
    capacity: 4,
    roomCount: 2,
    managerName: 'میلادی',
    managerPhoneNumber: 0912345678,
    guestCount: 2,
    booker: 'محمد حسینی',
    cleaningFee: 10000,
    serviceFee: 5000,
    totalFee: 215000,
    bookerPhoneNumber: 0912345678,
    bookerEmail: 'mohammadhossein@gmail.com',
    transactions: [
      TransactionModel(
        transactionId: '123456783',
        transactionStatus: false,
        transactionFee: 215000,
        createdAt: '1404/06/01',
      ),
      TransactionModel(
        transactionId: '123456784',
        transactionStatus: true,
        transactionFee: 215000,
        createdAt: '1404/06/01',
      ),
    ],
  ),
  ReservationModel(
    id: 3,
    title: 'ویلا لوکس',
    city: 'تهران',
    province: 'تهران',
    startDate: '1404/06/01',
    endDate: '1404/06/10',
    price: 100000,
    capacity: 4,
    roomCount: 2,
    managerName: 'میلادی',
    managerPhoneNumber: 0912345678,
    guestCount: 2,
    booker: 'محمد حسینی',
    cleaningFee: 10000,
    serviceFee: 5000,
    totalFee: 115000,
    bookerPhoneNumber: 0912345678,
    bookerEmail: 'mohammadhossein@gmail.com',
    transactions: [
      TransactionModel(
        transactionId: '123456785',
        transactionStatus: true,
        transactionFee: 115000,
        createdAt: '1404/06/01',
      ),
    ],
  ),
  ReservationModel(
    id: 4,
    title: 'خانه سنتی',
    city: 'تهران',
    province: 'تهران',
    startDate: '1404/06/01',
    endDate: '1404/06/10',
    price: 100000,
    capacity: 4,
    roomCount: 2,
    managerName: 'میلادی',
    managerPhoneNumber: 0912345678,
    guestCount: 2,
    booker: 'محمد حسینی',
    cleaningFee: 10000,
    serviceFee: 5000,
    totalFee: 115000,
    bookerPhoneNumber: 0912345678,
    bookerEmail: 'mohammadhossein@gmail.com',
    transactions: [
      TransactionModel(
        transactionId: '123456786',
        transactionStatus: true,
        transactionFee: 115000,
        createdAt: '1404/06/01',
      ),
    ],
  ),
  ReservationModel(
    id: 5,
    title: 'ویلا کوهستانی',
    city: 'تهران',
    province: 'تهران',
    startDate: '1404/06/01',
    endDate: '1404/06/10',
    price: 100000,
    capacity: 4,
    roomCount: 2,
    managerName: 'میلادی',
    managerPhoneNumber: 0912345678,
    guestCount: 2,
    booker: 'محمد حسینی',
    cleaningFee: 10000,
    serviceFee: 5000,
    totalFee: 115000,
    bookerPhoneNumber: 0912345678,
    bookerEmail: 'mohammadhossein@gmail.com',
    transactions: [
      TransactionModel(
        transactionId: '123456787',
        transactionStatus: true,
        transactionFee: 115000,
        createdAt: '1404/06/01',
      ),
    ],
  ),
  ReservationModel(
    id: 6,
    title: 'ویلا کوهستانی',
    city: 'تهران',
    province: 'تهران',
    startDate: '1404/06/01',
    endDate: '1404/06/10',
    price: 100000,
    capacity: 4,
    roomCount: 2,
    managerName: 'میلادی',
    managerPhoneNumber: 0912345678,
    guestCount: 2,
    booker: 'محمد حسینی',
    cleaningFee: 10000,
    serviceFee: 5000,
    totalFee: 115000,
    bookerPhoneNumber: 0912345678,
    bookerEmail: 'mohammadhossein@gmail.com',
    transactions: [
      TransactionModel(
        transactionId: '123456788',
        transactionStatus: true,
        transactionFee: 115000,
        createdAt: '1404/06/01',
      ),
    ],
  ),
];

class ReservationsListScreen extends StatelessWidget {
  const ReservationsListScreen({super.key});

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
      body: ListView.builder(
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
            title: Text(reservation.title),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  reservation.booker!,
                  style: const TextStyle(
                    color: AppColors.grey700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${formatNumberToPersianWithoutSeparator(reservation.startDate)} - ${formatNumberToPersianWithoutSeparator(reservation.endDate)}',
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
      ),
    );
  }
}
