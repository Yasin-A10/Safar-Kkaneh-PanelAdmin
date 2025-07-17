import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/convert_to_jalali.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/models/transaction_model.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final reservation = transaction.reservation;
    final residence = reservation?.residence ?? transaction.residence;
    final user = transaction.user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.warning150,
        automaticallyImplyLeading: false,
        title: const Text(
          'جزئیات تراکنش',
          style: TextStyle(color: AppColors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left, color: AppColors.white),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.warning150, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(transaction),
              _buildTransactionMeta(transaction),
              _buildUserInfo(user),
              _buildReservationInfo(reservation),
              _buildResidenceInfo(residence),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(TransactionModel transaction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'تراکنش شماره ${formatNumberToPersian(transaction.id)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.grey900,
              ),
            ),
            const Spacer(),
            Text(
              transaction.status == 'confirmed'
                  ? 'پرداخت موفق'
                  : 'پرداخت ناموفق',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: transaction.status == 'confirmed'
                    ? AppColors.success200
                    : AppColors.error300,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(color: AppColors.warning150),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTransactionMeta(TransactionModel transaction) {
    return Column(
      children: [
        _infoRow(
          Iconsax.calendar_2,
          'تاریخ تراکنش',
          formatNumberToPersianWithoutSeparator(
            convertToJalaliDate(transaction.createdAt.toString()),
          ),
        ),
        const SizedBox(height: 8),
        _infoRow(
          Iconsax.moneys,
          'مبلغ',
          '${formatNumberToPersian(transaction.amount)} تومان',
        ),
        const SizedBox(height: 8),
        _infoRow(
          Iconsax.document,
          'نوع تراکنش',
          _getTransactionTypeTitle(transaction.type),
        ),
        const SizedBox(height: 16),
        const Divider(color: AppColors.warning150),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildUserInfo(SimpleUser user) {
    return Column(
      children: [
        _infoRow(Iconsax.user, 'نام کاربر', user.fullName),
        const SizedBox(height: 8),
        _infoRow(
          Iconsax.mobile,
          'شماره همراه',
          formatNumberToPersianWithoutSeparator(user.phoneNumber),
        ),
        if (user.email != null) ...[
          const SizedBox(height: 8),
          _infoRow(Iconsax.message, 'ایمیل', user.email!),
        ],
        const SizedBox(height: 16),
        const Divider(color: AppColors.warning150),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildReservationInfo(SimpleReservation? res) {
    if (res == null) return const SizedBox.shrink();
    return Column(
      children: [
        _infoRow(
          Iconsax.calendar,
          'تاریخ ورود',
          formatNumberToPersianWithoutSeparator(
            convertToJalaliDate(res.checkIn ?? ''),
          ),
        ),
        const SizedBox(height: 8),
        _infoRow(
          Iconsax.calendar_1,
          'تاریخ خروج',
          formatNumberToPersianWithoutSeparator(
            convertToJalaliDate(res.checkOut ?? ''),
          ),
        ),
        const SizedBox(height: 8),
        _infoRow(
          Iconsax.people,
          'تعداد مهمان',
          formatNumberToPersian(res.guestCount ?? 0),
        ),
        const SizedBox(height: 8),
        _infoRow(
          Iconsax.coin,
          'مبلغ رزرو',
          '${formatNumberToPersian(res.totalPrice ?? 0)} تومان',
        ),
        const SizedBox(height: 16),
        const Divider(color: AppColors.warning150),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildResidenceInfo(SimpleResidence? res) {
    if (res == null) return const SizedBox.shrink();
    return Column(
      children: [
        _infoRow(Iconsax.house, 'نام اقامتگاه', res.title),
        const SizedBox(height: 8),
        _infoRow(Iconsax.personalcard, 'مالک', res.owner.fullName),
        const SizedBox(height: 8),
        _infoRow(
          Iconsax.call,
          'شماره تماس',
          formatNumberToPersianWithoutSeparator(res.owner.phoneNumber),
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.grey400, size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.grey400,
              ),
            ),
          ],
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.grey500,
            ),
          ),
        ),
      ],
    );
  }

  String _getTransactionTypeTitle(String type) {
    switch (type) {
      case 'topup':
        return 'شارژ کیف پول';
      case 'online':
        return 'پرداخت آنلاین';
      case 'wallet':
        return 'پرداخت از کیف پول';
      case 'cash':
        return 'پرداخت نقدی';
      case 'refund':
        return 'بازگشت وجه';
      case 'payout':
        return 'تسویه حساب با مالک';
      default:
        return 'نامشخص';
    }
  }
}

class TransactionUser {
  final String fullName;
  final String phoneNumber;
  final String? email;

  TransactionUser({
    required this.fullName,
    required this.phoneNumber,
    this.email,
  });

  factory TransactionUser.fromJson(Map<String, dynamic> json) {
    return TransactionUser(
      fullName: json['full_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'],
    );
  }
}

class ResidenceInTransaction {
  final String title;
  final ResidenceOwner owner;

  ResidenceInTransaction({required this.title, required this.owner});

  factory ResidenceInTransaction.fromJson(Map<String, dynamic> json) {
    return ResidenceInTransaction(
      title: json['title'] ?? '',
      owner: ResidenceOwner.fromJson(json['owner']),
    );
  }
}

class ResidenceOwner {
  final String fullName;
  final String phoneNumber;

  ResidenceOwner({required this.fullName, required this.phoneNumber});

  factory ResidenceOwner.fromJson(Map<String, dynamic> json) {
    return ResidenceOwner(
      fullName: json['full_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
    );
  }
}
