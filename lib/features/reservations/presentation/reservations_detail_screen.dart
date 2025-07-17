import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safar_khaneh_panel/config/router/app_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/convert_to_jalali.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/models/reservation_model.dart';
import 'package:safar_khaneh_panel/data/api/reservation_services.dart';

class ReservationsDetailScreen extends StatefulWidget {
  final ReservationModel reservation;
  const ReservationsDetailScreen({super.key, required this.reservation});

  @override
  State<ReservationsDetailScreen> createState() =>
      _ReservationsDetailScreenState();
}

class _ReservationsDetailScreenState extends State<ReservationsDetailScreen> {
  final ReservationService _reservationService = ReservationService();

  void _handleCancelReservation(context) async {
    try {
      await _reservationService.cancelReservation(widget.reservation.id);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            'لغو با موفقیت انجام شد',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: AppColors.success200,
          duration: const Duration(milliseconds: 1800),
        ),
      );

      Future.delayed(const Duration(milliseconds: 1900), () {
        GoRouter.of(navigatorKey.currentContext!).go('/reservations');
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text('خطا در لغو رزرو', textDirection: TextDirection.rtl),
          backgroundColor: AppColors.error200,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.error300,
        automaticallyImplyLeading: false,
        leading: PopupMenuButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            side: BorderSide(color: AppColors.white, width: 2),
          ),
          elevation: 8,
          offset: const Offset(0, 48),
          icon: const Icon(Iconsax.menu, color: AppColors.white),
          onSelected: (value) {
            if (value == 'deleteReservation') {
              _handleCancelReservation(context);
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 'deleteReservation',
                child: Text(
                  'لغو رزرو',
                  style: TextStyle(
                    color: AppColors.error300,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ];
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left, color: AppColors.white),
            onPressed: () {
              context.pop();
            },
          ),
        ],
        title: Text(
          widget.reservation.residence.title,
          style: const TextStyle(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.error200, width: 1.5),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.reservation.residence.title,
                              style: const TextStyle(
                                color: AppColors.grey900,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 8),
                            widget.reservation.status == 'confirmed'
                                ? const Icon(
                                    Iconsax.tick_circle,
                                    color: AppColors.success200,
                                  )
                                : const Icon(
                                    Iconsax.close_circle,
                                    color: AppColors.error200,
                                  ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          '${widget.reservation.residence.location.city.name}, ${widget.reservation.residence.location.city.province.name}',
                          style: const TextStyle(
                            color: AppColors.grey600,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'رزرو کننده: ${widget.reservation.user.fullName}',
                      style: const TextStyle(
                        color: AppColors.grey700,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16),
                    const Divider(color: AppColors.error200, thickness: 1),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.timer_start,
                              color: AppColors.grey400,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'تاریخ شروع',
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
                            convertToJalaliDate(widget.reservation.checkIn),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.timer_pause,
                              color: AppColors.grey400,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'تاریخ پایان',
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
                            convertToJalaliDate(widget.reservation.checkOut),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.profile_2user,
                              color: AppColors.grey400,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'تعداد نفرات',
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
                            widget.reservation.guestCount.toString(),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
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
                          widget.reservation.residence.owner.fullName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.call,
                              color: AppColors.grey400,
                              size: 24,
                            ),
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
                            widget.reservation.residence.owner.phoneNumber,
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    const Divider(color: AppColors.error200, thickness: 1),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.money_4,
                              color: AppColors.grey400,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'قیمت هر شب',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.grey400,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          formatNumberToPersian(
                            widget.reservation.pricePerNightSnapshot,
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.money_3,
                              color: AppColors.grey400,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'هزینه نظافت',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.grey400,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          formatNumberToPersian(
                            widget.reservation.cleaningPriceSnapshot,
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.money_2,
                              color: AppColors.grey400,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'هزینه خدمات',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.grey400,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          formatNumberToPersian(
                            widget.reservation.servicesPriceSnapshot,
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
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
                              'هزینه کل',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.grey500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          formatNumberToPersian(widget.reservation.totalPrice),
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
              const SizedBox(height: 32),
              Column(
                spacing: 16,
                children: widget.reservation.payments.map((payment) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: payment.status == 'confirmed'
                          ? Border.all(color: AppColors.success200, width: 2)
                          : Border.all(color: AppColors.error300, width: 2),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'شماره تراکنش: ${formatNumberToPersianWithoutSeparator(payment.id)}',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.grey700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      'مبلغ: ${formatNumberToPersian(payment.amount)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.grey500,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '.',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.grey500,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    if (payment.type == 'cash')
                                      const Text(
                                        'پرداخت نقدی',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.grey500,
                                        ),
                                      ),
                                    if (payment.type == 'online')
                                      const Text(
                                        'پرداخت آنلاین',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.grey500,
                                        ),
                                      ),
                                    if (payment.type == 'wallet')
                                      const Text(
                                        'پرداخت از کیف پول',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.grey500,
                                        ),
                                      ),
                                    if (payment.type != 'cash' &&
                                        payment.type != 'online' &&
                                        payment.type != 'wallet')
                                      const Text(
                                        'بازگشت وجه به کیف پول',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.grey500,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            payment.status == 'confirmed'
                                ? const Text(
                                    'موفق',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.success200,
                                    ),
                                  )
                                : const Text(
                                    'ناموفق',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.error300,
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
