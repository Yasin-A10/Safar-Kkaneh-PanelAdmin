import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/features/discount/create_discount_form.dart';
import 'package:safar_khaneh_panel/data/models/discount_model.dart';

final List<DiscountModel> discounts = [
  DiscountModel(
    id: 1,
    title: 'Spring1404',
    code: 'DISCOUNT1',
    discountValue: 10,
    startDate: '1400/01/01',
    endDate: '1400/01/31',
  ),
  DiscountModel(
    id: 2,
    title: 'winter1400',
    code: 'DISCOUNT2',
    discountValue: 20,
    startDate: '1400/02/01',
    endDate: '1400/02/28',
  ),
  DiscountModel(
    id: 3,
    title: 'Summer1404',
    code: 'DISCOUNT3',
    discountValue: 30,
    startDate: '1400/03/01',
    endDate: '1400/03/31',
  ),
  DiscountModel(
    id: 4,
    title: 'Spring1401',

    code: 'DISCOUNT4',
    discountValue: 40,
    startDate: '1400/04/01',
    endDate: '1400/04/30',
  ),
  DiscountModel(
    id: 5,
    title: 'Spring1403',

    code: 'DISCOUNT5',
    discountValue: 50,
    startDate: '1400/05/01',
    endDate: '1400/05/31',
  ),
  DiscountModel(
    id: 6,
    title: 'Spring1402',
    code: 'DISCOUNT6',
    discountValue: 50,
    startDate: '1400/06/01',
    endDate: '1400/06/30',
  ),
];

class DiscountScreen extends StatelessWidget {
  const DiscountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'تخفیف ها',
            style: TextStyle(color: Colors.deepPurple),
          ),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.arrow_left, color: Colors.deepPurple),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
        body: Container(
          child: ListView.builder(
            itemCount: discounts.length,
            itemBuilder: (context, index) {
              final discount = discounts[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Text(
                    formatNumberToPersian(discount.id),
                    style: const TextStyle(color: AppColors.white),
                  ),
                ),
                title: Row(
                  children: [
                    Text(discount.title),
                    const SizedBox(width: 4),
                    Text('.'),
                    const SizedBox(width: 4),
                    Text(
                      discount.code,
                      style: TextStyle(color: AppColors.grey600),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text(
                      '${formatNumberToPersian(discount.discountValue)}% تخفیف',
                      style: const TextStyle(
                        color: AppColors.grey700,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${formatNumberToPersianWithoutSeparator(discount.startDate)} - ${formatNumberToPersianWithoutSeparator(discount.endDate)}',
                      style: const TextStyle(
                        color: AppColors.grey500,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          foregroundColor: AppColors.white,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const CreateDiscountForm(),
              ),
            );
          },

          child: const Icon(Iconsax.add, size: 32),
        ),
      ),
    );
  }
}
