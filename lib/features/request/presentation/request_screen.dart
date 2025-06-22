import 'package:flutter/material.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/models/request_model.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

final List<RequestModel> requests = [
  RequestModel(
    id: 1,
    title: 'ویلا کویری',
    managerName: 'مهدی حسامی',
    managerPhoneNumber: '0912345678',
    city: 'قم',
    province: 'قم',
    address: 'قم، خیابان میدان آزادی، خیابان میدان آزادی، خیابان میدان آزادی',
    latitude: 35.6895,
    longitude: 51.3892,
    pictureUrl: 'assets/images/Residences/1.jpg',
  ),
  RequestModel(
    id: 2,
    title: 'ویلا کوهستانی',
    managerName: 'مهدی حسومی',
    managerPhoneNumber: '0912345678',
    city: 'گیلان',
    province: 'رشت',
    address: 'قم، خیابان میدان آزادی، خیابان میدان آزادی، خیابان میدان آزادی',
    latitude: 35.6895,
    longitude: 51.3892,
    pictureUrl: 'assets/images/Residences/5.jpg',
  ),
  RequestModel(
    id: 3,
    title: 'ویلا شخمی',
    managerName: 'مهدی رضایی',
    managerPhoneNumber: '0912345678',
    city: 'تهران',
    province: 'تهران',
    address: 'قم، خیابان میدان آزادی، خیابان میدان آزادی، خیابان میدان آزادی',
    latitude: 35.6895,
    longitude: 51.3892,
    pictureUrl: 'assets/images/Residences/4.jpg',
  ),
  RequestModel(
    id: 4,
    title: 'ویلا زشت',
    managerName: 'محمد جعفری',
    managerPhoneNumber: '0912345678',
    city: 'کرمانشاه',
    province: 'کرمانشاه',
    address: 'قم، خیابان میدان آزادی، خیابان میدان آزادی، خیابان میدان آزادی',
    latitude: 35.6895,
    longitude: 51.3892,
    pictureUrl: 'assets/images/Residences/3.jpg',
  ),
];

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'درخواست‌های ثبت اقامتگاه',
          style: TextStyle(color: AppColors.grey800),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left, color: AppColors.grey800),
            onPressed: () {
              context.pop();
            },
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final request = requests[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.grey900,
                child: Text(
                  formatNumberToPersian(request.id),
                  style: const TextStyle(color: AppColors.white),
                ),
              ),
              title: Text(request.title),
              subtitle: Row(
                children: [
                  Text(
                    'مدیر: ${request.managerName}',
                    style: const TextStyle(
                      color: AppColors.grey700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${request.city}، ${request.province}',
                    style: const TextStyle(
                      color: AppColors.grey500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              trailing: const Icon(Iconsax.eye, color: AppColors.grey800),
              onTap: () {
                context.push('/request/${request.id}', extra: request);
              },
            );
          },
        ),
      ),
    );
  }
}
