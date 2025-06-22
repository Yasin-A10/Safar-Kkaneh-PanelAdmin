import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/models/reservation_model.dart';

List<ReservationModel> reservations = [
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
    booker: 'محمدرضا عباسی',
    cleaningFee: 10000,
    serviceFee: 5000,
    totalFee: 115000,
    bookerPhoneNumber: 0912345678,
    bookerEmail: 'mohammadhossein@gmail.com',
    transactions: [
      TransactionModel(
        transactionId: '781',
        transactionStatus: false,
        transactionFee: 115000,
        createdAt: '1404/06/01',
      ),
      TransactionModel(
        transactionId: '783',
        transactionStatus: false,
        transactionFee: 115000,
        createdAt: '1404/06/01',
      ),
      TransactionModel(
        transactionId: '782',
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
        transactionId: '783',
        transactionStatus: false,
        transactionFee: 215000,
        createdAt: '1404/06/01',
      ),
      TransactionModel(
        transactionId: '784',
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
        transactionId: '76',
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
        transactionId: '86',
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
        transactionId: '143',
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
        transactionId: '13',
        transactionStatus: true,
        transactionFee: 115000,
        createdAt: '1404/06/01',
      ),
    ],
  ),
];

class TransactionsListScreen extends StatelessWidget {
  const TransactionsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'تراکنش ها',
          style: TextStyle(color: AppColors.warning150),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left, color: AppColors.warning150),
            onPressed: () {
              context.pop();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: reservations
            .expand((reservation) => reservation.transactions ?? [])
            .length,
        itemBuilder: (context, index) {
          //* Getting all transactions as a flat list
          final allTransactions = reservations
              .expand((reservation) => reservation.transactions ?? [])
              .toList();
          final transaction = allTransactions[index];

          //* Find the reservation associated with this transaction
          final reservation = reservations.firstWhere(
            (res) => res.transactions?.contains(transaction) ?? false,
          );

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.warning150,
              child: Text(
                formatNumberToPersian(int.parse(transaction.transactionId)),
                style: const TextStyle(color: AppColors.white),
              ),
            ),
            title: Text(reservation.title),
            subtitle: Row(
              children: [
                Text(
                  reservation.booker ?? 'نامشخص',
                  style: const TextStyle(
                    color: AppColors.grey700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  formatNumberToPersianWithoutSeparator(transaction.createdAt),
                  style: const TextStyle(
                    color: AppColors.grey500,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${formatNumberToPersian(transaction.transactionFee)} تومان',
                  style: TextStyle(
                    color: transaction.transactionStatus
                        ? AppColors.success200
                        : AppColors.error300,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            trailing: const Icon(Iconsax.eye),
            onTap: () {
              final allTransactions = reservations
                  .expand((res) => res.transactions ?? [])
                  .toList();
              final transaction = allTransactions[index];
              context.push(
                '/transaction/${transaction.transactionId}',
                extra: {
                  'transaction': transaction,
                  'reservations': reservations,
                },
              );
            },
          );
        },
      ),
    );
  }
}
