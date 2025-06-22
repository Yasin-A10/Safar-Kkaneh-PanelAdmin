import 'package:flutter/material.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/widgets/button.dart';
import 'package:safar_khaneh_panel/widgets/date_picker.dart';
import 'package:safar_khaneh_panel/widgets/inputs/drop_down_field.dart';
import 'package:safar_khaneh_panel/widgets/inputs/text_field.dart';

class CreateDiscountForm extends StatefulWidget {
  const CreateDiscountForm({super.key});

  @override
  State<CreateDiscountForm> createState() => _CreateDiscountFormState();
}

class _CreateDiscountFormState extends State<CreateDiscountForm> {
  final List<int> _discountTypes = [10, 20, 30, 40, 50];
  int? _selectedDiscountType;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'ایجاد تخفیف جدید',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          InputTextField(label: 'عنوان تخفیف'),
          const SizedBox(height: 16),
          InputTextField(label: 'کد تخفیف'),
          const SizedBox(height: 16),
          DatePicker(
            onRangeSelected: (start, end) {
              // می‌تونی تاریخ‌ها رو ذخیره کنی یا به سرور بفرستی
            },
          ),
          const SizedBox(height: 20),
          DropdownField<int>(
            label: 'مقدار تخفیف',
            items: _discountTypes,
            value: _selectedDiscountType,
            onChanged: (value) {
              setState(() {
                _selectedDiscountType = value;
              });
            },
            itemLabel: (item) => item.toString(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'لغو',
                  style: TextStyle(
                    color: AppColors.error300,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Button(
                onPressed: () {},
                label: 'ثبت',
                backgroundColor: Colors.deepPurple,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
