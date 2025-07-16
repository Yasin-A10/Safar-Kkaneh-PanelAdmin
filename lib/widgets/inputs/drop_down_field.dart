import 'package:flutter/material.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';

class DropdownField<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final T? value;
  final void Function(T?) onChanged;
  final String Function(T) itemLabel;
  final String? hintText;
  // final String Function(T?) validator;

  const DropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemLabel,
    this.hintText,
    // required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: TextStyle(color: AppColors.grey500),
        floatingLabelStyle: TextStyle(
          color: AppColors.primary800,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.grey600, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.primary800, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      value: value,
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            '${formatNumberToPersianWithoutSeparator(itemLabel(item))}%',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      // validator: validator,
    );
  }
}
