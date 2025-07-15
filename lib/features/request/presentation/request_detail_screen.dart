import 'package:flutter/material.dart';
import 'package:safar_khaneh_panel/config/router/app_router.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/api/request_services.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/data/models/residence_model.dart';
import 'package:safar_khaneh_panel/widgets/button.dart';
import 'package:safar_khaneh_panel/widgets/map.dart';

class RequestDetailScreen extends StatefulWidget {
  final ResidenceModel request;
  const RequestDetailScreen({super.key, required this.request});

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  final RequestServices _requestService = RequestServices();
  
  @override
  void initState() {
    super.initState();
  }

  bool _isLoading = false;

  void _addRequest(context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await _requestService.updatePendingResidence(id: widget.request.id!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            'اضافه با موفقیت انجام شد',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: AppColors.success200,
          duration: const Duration(milliseconds: 1800),
        ),
      );

      Future.delayed(const Duration(milliseconds: 1900), () {
        GoRouter.of(navigatorKey.currentContext!).go('/requests');
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            'خطا در اضافه کردن درخواست',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: AppColors.error200,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleDeleteRequest(context) async {
    try {
      await _requestService.deletePendingResidence(widget.request.id!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            'حذف با موفقیت انجام شد',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: AppColors.success200,
          duration: const Duration(milliseconds: 1800),
        ),
      );

      Future.delayed(const Duration(milliseconds: 1900), () {
        GoRouter.of(navigatorKey.currentContext!).go('/requests');
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text('خطا در حذف درخواست', textDirection: TextDirection.rtl),
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
        backgroundColor: AppColors.grey900,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(right: 7.1),
          child: PopupMenuButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              side: BorderSide(color: AppColors.white, width: 2),
            ),
            elevation: 8,
            offset: const Offset(0, 48),
            icon: const Icon(Iconsax.menu, color: AppColors.white),
            onSelected: (value) {
              if (value == 'deleteRequest') {
                _handleDeleteRequest(context);
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'deleteRequest',
                  child: Text(
                    'حذف این درخواست',
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
        ),
        title: Text(
          widget.request.title!,
          style: const TextStyle(color: AppColors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left, color: AppColors.white),
            onPressed: () {
              context.pop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.grey400, width: 1.5),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.request.title!,
                          style: const TextStyle(
                            color: AppColors.grey900,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${widget.request.location?.city?.name ?? 'شهر'}, ${widget.request.location?.city?.province?.name ?? 'استان'}',
                          style: const TextStyle(
                            color: AppColors.grey600,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: AppColors.grey300, thickness: 1),
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
                            Text(
                              'مدیر:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.grey400,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.request.owner?.fullName ?? 'نامشخص',
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
                              Iconsax.call,
                              color: AppColors.grey400,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'شماره تماس:',
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
                            widget.request.owner?.phoneNumber ?? '0000000000',
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
                    const Divider(color: AppColors.grey300, thickness: 1),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.location,
                              color: AppColors.grey400,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'آدرس:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.grey400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(right: 36),
                          child: Text(
                            widget.request.location?.address ??
                                'آدرسی وجود ندارد',
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    MapWidget(
                      latitude: widget.request.location?.lat ?? '35.6895',
                      longitude: widget.request.location?.lng ?? '51.3891',
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: AppColors.grey300, thickness: 1),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.document_text,
                              color: AppColors.grey400,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'سند اقامتگاه:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.grey400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: widget.request.documentUrl != null
                              ? Image.asset(
                                  'assets/images/Residences/Not-Found.jpg',
                                  height: 400,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  widget.request.documentUrl!,
                                  height: 400,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 20,
          top: 12,
        ),
        decoration: const BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, -4),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Button(
          backgroundColor: AppColors.grey900,
          onPressed: () {
            _addRequest(context);
          },
          label: 'تایید اقامتگاه',
          width: double.infinity,
          isLoading: _isLoading,
          enabled: !_isLoading,
        ),
      ),
    );
  }
}
