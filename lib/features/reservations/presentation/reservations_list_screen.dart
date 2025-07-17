import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/convert_to_jalali.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/models/reservation_model.dart';
import 'package:safar_khaneh_panel/data/api/reservation_services.dart';
import 'package:safar_khaneh_panel/widgets/button.dart';
import 'package:safar_khaneh_panel/widgets/search_bar.dart';

class ReservationsListScreen extends StatefulWidget {
  const ReservationsListScreen({super.key});

  @override
  State<ReservationsListScreen> createState() => _ReservationsListScreenState();
}

class _ReservationsListScreenState extends State<ReservationsListScreen> {
  final ReservationService _reservationService = ReservationService();
  late Future<List<ReservationModel>> _reservations;

  String? _selectedStatus;
  String? _selectedType;

  final List<Map<String, String>> statusOptions = [
    {'label': 'پرداخت ناموفق', 'value': 'failed_payment'},
    {'label': 'تایید شده', 'value': 'confirmed'},
    {'label': 'در انتظار تایید', 'value': 'pending'},
    {'label': 'لغو شده', 'value': 'cancelled'},
  ];

  final List<Map<String, String>> typeOptions = [
    {'label': 'پرداخت آنلاین', 'value': 'online'},
    {'label': 'پرداخت با کیف پول', 'value': 'wallet'},
    {'label': 'پرداخت نقدی', 'value': 'cash'},
  ];

  @override
  void initState() {
    super.initState();
    _reservations = _reservationService.fetchReservations();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _reservations = _reservationService.fetchReservations();
    });
  }

  void _handleSearch(String query) async {
    final result = await _reservationService.fetchReservations(query: query);
    setState(() {
      _reservations = Future.value(result);
    });
  }

  void _handleFilter(String? status, String? type) async {
    final result = await _reservationService.fetchReservations(
      status: status,
      type: type,
    );
    setState(() {
      _reservations = Future.value(result);
    });
  }

  void showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'فیلترها',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary800,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'انتخاب وضعیت',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...statusOptions.map((option) {
                        return RadioListTile<String>(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          visualDensity: const VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                          title: Text(option['label']!),
                          value: option['value']!,
                          groupValue: _selectedStatus,
                          onChanged: (value) {
                            setModalState(() {
                              if (_selectedStatus == value) {
                                _selectedStatus = null;
                              } else {
                                _selectedStatus = value;
                              }
                            });
                          },
                        );
                      }),
                      const SizedBox(height: 32),
                      const Text(
                        'انتخاب نوع پرداخت',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...typeOptions.map((option) {
                        return RadioListTile<String>(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          visualDensity: const VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                          title: Text(option['label']!),
                          value: option['value']!,
                          groupValue: _selectedType,
                          onChanged: (value) {
                            setModalState(() {
                              if (_selectedType == value) {
                                _selectedType = null;
                              } else {
                                _selectedType = value;
                              }
                            });
                          },
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () => context.pop(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.error200, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          'بازگشت',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.error200,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Button(
                          label: 'اعمال فیلتر',
                          onPressed: () {
                            _handleFilter(_selectedStatus, _selectedType);
                            context.pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Iconsax.filter),
                  onPressed: () {
                    showFilterDialog(context);
                  },
                ),
                Expanded(
                  child: CustomSearchBar(
                    onSearch: _handleSearch,
                    hintText: 'جستجو...',
                  ),
                ),
              ],
            ),
          ),
        ),
        title: const Text(
          'لیست رزرو ها',
          style: TextStyle(color: AppColors.error300),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left, color: AppColors.error300),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: FutureBuilder(
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
                  title: Row(
                    children: [
                      Text(reservation.residence.title),
                      const SizedBox(width: 8),
                      reservation.status == 'confirmed'
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
      ),
    );
  }
}
