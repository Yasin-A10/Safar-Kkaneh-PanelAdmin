import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/models/residence_model.dart';
import 'package:safar_khaneh_panel/widgets/button.dart';
import 'package:safar_khaneh_panel/widgets/feature_selector.dart';
import 'package:safar_khaneh_panel/widgets/inputs/text_field.dart';

class ResidencesEditScreen extends StatefulWidget {
  final ResidenceModel residence;
  const ResidencesEditScreen({super.key, required this.residence});

  @override
  State<ResidencesEditScreen> createState() => _ResidencesEditScreenState();
}

class _ResidencesEditScreenState extends State<ResidencesEditScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController managerController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final TextEditingController roomCountController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController cleaningFeeController = TextEditingController();
  final TextEditingController serviceFeeController = TextEditingController();
  List<String> facilities = [];

  @override
  void initState() {
    titleController.text = widget.residence.title;
    descriptionController.text = widget.residence.description.toString();
    managerController.text = widget.residence.manager!;
    roomCountController.text = formatNumberToPersianWithoutSeparator(
      widget.residence.roomCount,
    );
    capacityController.text = formatNumberToPersianWithoutSeparator(
      widget.residence.capacity,
    );
    phoneNumberController.text = formatNumberToPersianWithoutSeparator(
      widget.residence.phoneNumber,
    );
    priceController.text = formatNumberToPersian(widget.residence.price);
    cleaningFeeController.text = formatNumberToPersian(
      widget.residence.cleaningFee!,
    );
    serviceFeeController.text = formatNumberToPersian(
      widget.residence.serviceFee!,
    );
    provinceController.text = widget.residence.province!;
    cityController.text = widget.residence.city!;
    facilities = widget.residence.facilities!;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    managerController.dispose();
    phoneNumberController.dispose();
    descriptionController.dispose();
    provinceController.dispose();
    cityController.dispose();
    capacityController.dispose();
    roomCountController.dispose();
    priceController.dispose();
    cleaningFeeController.dispose();
    serviceFeeController.dispose();
    facilities.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondary500,
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
              if (value == 'delete') {}
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'delete',
                  child: Text(
                    'حذف اقامتگاه',
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
            widget.residence.title,
            style: const TextStyle(color: AppColors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputTextField(
                  label: 'عنوان',
                  initialValue: titleController,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 16),
                InputTextField(
                  label: 'مدیریت',
                  initialValue: managerController,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 16),
                InputTextField(
                  label: 'شماره تماس',
                  initialValue: phoneNumberController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                FeaturesSelector(
                  allFeatures: const ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
                  selectedFeatures: facilities,
                  onChanged: (selectedFeatures) {
                    setState(() {
                      facilities = selectedFeatures;
                    });
                  },
                ),
                SizedBox(height: 16),
                InputTextField(
                  label: 'توضیحات',
                  initialValue: descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 6,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InputTextField(
                        label: 'استان',
                        initialValue: provinceController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InputTextField(
                        label: 'شهر',
                        initialValue: cityController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InputTextField(
                        label: 'ظرفیت نفرات',
                        initialValue: capacityController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InputTextField(
                        label: 'تعداد اتاق خواب',
                        initialValue: roomCountController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                InputTextField(
                  label: 'قیمت هر شب',
                  initialValue: priceController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InputTextField(
                        label: 'قیمت نظافت',
                        initialValue: cleaningFeeController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InputTextField(
                        label: 'قیمت خدمات',
                        initialValue: serviceFeeController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Button(
                  label: 'ذخیره',
                  onPressed: () {},
                  width: double.infinity,
                  backgroundColor: AppColors.secondary500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
