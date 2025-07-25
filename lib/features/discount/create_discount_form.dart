import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/validators.dart';
import 'package:safar_khaneh_panel/widgets/button.dart';
import 'package:safar_khaneh_panel/widgets/date_picker.dart';
import 'package:safar_khaneh_panel/widgets/inputs/drop_down_field.dart';
import 'package:safar_khaneh_panel/widgets/inputs/text_form_field.dart';
import 'package:safar_khaneh_panel/data/api/discount_services.dart';

class CreateDiscountForm extends StatefulWidget {
  const CreateDiscountForm({super.key});

  @override
  State<CreateDiscountForm> createState() => _CreateDiscountFormState();
}

class _CreateDiscountFormState extends State<CreateDiscountForm> {
  final List<int> _discountTypes = [10, 20, 30, 40, 50, 60, 70, 80, 90];
  int? _selectedDiscountType;

  final GlobalKey<FormState> _addDiscountFormKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  String? _startDate;
  String? _endDate;

  void _handleAddDiscount(context) async {
    if (!_addDiscountFormKey.currentState!.validate()) {
      return;
    }

    try {
      if (_startDate == null || _endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('لطفا تاریخ شروع و پایان را انتخاب کنید')),
        );
        return;
      }
      await DiscountService().createDiscount(
        title: _titleController.text,
        code: _codeController.text,
        description: 'توضیحات کد تخفیف',
        discountPercentage: _selectedDiscountType!,
        startDate: _startDate!,
        endDate: _endDate!,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('تخفیف با موفقیت اضافه شد')));
      GoRouter.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('خطا در ایجاد تخفیف: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _addDiscountFormKey,
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
            InputTextFormField(
              label: 'عنوان تخفیف',
              controller: _titleController,
              validator: (value) {
                return AppValidator.userName(value, fieldName: 'عنوان تخفیف');
              },
            ),
            const SizedBox(height: 16),
            InputTextFormField(
              label: 'کد تخفیف',
              controller: _codeController,
              validator: (value) {
                return AppValidator.discountCode(value);
              },
            ),
            const SizedBox(height: 16),
            DatePicker(
              onRangeSelected: (start, end) {
                setState(() {
                  _startDate = start
                      .toDateTime()
                      .toIso8601String()
                      .split('T')
                      .first;
                  _endDate = end
                      .toDateTime()
                      .toIso8601String()
                      .split('T')
                      .first;
                });
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
              // validator: (value) {
              //   return AppValidator.discountPercentageValidator(value);
              // },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => context.pop(),
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
                  onPressed: () {
                    _handleAddDiscount(context);
                  },
                  label: 'ثبت',
                  backgroundColor: Colors.deepPurple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
