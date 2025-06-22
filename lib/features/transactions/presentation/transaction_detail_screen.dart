import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/models/reservation_model.dart';

class TransactionDetailScreen extends StatefulWidget {
  final List<ReservationModel> reservations;
  final TransactionModel transaction; // تغییر به TransactionModel
  const TransactionDetailScreen({
    super.key,
    required this.transaction,
    required this.reservations,
  });

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // پیدا کردن رزرو مرتبط با این تراکنش
    final reservation = widget.reservations.firstWhere(
      (res) => res.transactions?.contains(widget.transaction) ?? false,
      orElse: () =>
          widget.reservations.first, // اگر پیدا نشد، اولین رزرو رو برگردون
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.warning150,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left, color: AppColors.white),
            onPressed: () {
              context.pop();
            },
          ),
        ],
        title: const Text(
          'جزئیات تراکنش',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.warning150, width: 1.5),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'تراکنش شماره ${formatNumberToPersianWithoutSeparator(widget.transaction.transactionId)}',
                      style: const TextStyle(
                        color: AppColors.grey900,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.transaction.transactionStatus
                          ? 'پرداخت موفق'
                          : 'پرداخت ناموفق',
                      style: TextStyle(
                        color: widget.transaction.transactionStatus
                            ? AppColors.success200
                            : AppColors.error300,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: AppColors.warning150, thickness: 1),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Iconsax.house, color: AppColors.grey400, size: 24),
                        const SizedBox(width: 8),
                        const Text(
                          'محل رزرو',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey400,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      reservation.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.personalcard,
                          color: AppColors.grey400,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'مدیریت',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey400,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      reservation.managerName!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Iconsax.call, color: AppColors.grey400, size: 24),
                        const SizedBox(width: 8),
                        const Text(
                          'شماره تماس',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey400,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      formatNumberToPersianWithoutSeparator(
                        reservation.managerPhoneNumber!,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: AppColors.warning150, thickness: 1),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Iconsax.user, color: AppColors.grey400, size: 24),
                        const SizedBox(width: 8),
                        const Text(
                          'نام شخص',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey400,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      reservation.booker!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.mobile,
                          color: AppColors.grey400,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'شماره همراه',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey400,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      formatNumberToPersianWithoutSeparator(
                        reservation.bookerPhoneNumber,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.message,
                          color: AppColors.grey400,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'ایمیل',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey400,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      reservation.bookerEmail ?? 'نامشخص',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: AppColors.warning150, thickness: 1),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.calendar_2,
                          color: AppColors.grey400,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'تاریخ تراکنش',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey400,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      formatNumberToPersianWithoutSeparator(
                        widget.transaction.createdAt,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.moneys,
                          color: AppColors.grey500,
                          size: 26,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'مبلغ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      formatNumberToPersian(widget.transaction.transactionFee),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
