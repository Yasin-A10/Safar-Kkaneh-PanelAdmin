import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/models/user_model.dart';
import 'package:safar_khaneh_panel/widgets/button.dart';
import 'package:safar_khaneh_panel/widgets/inputs/text_field.dart';

class UsersEditScreen extends StatefulWidget {
  final UserModel user;
  const UsersEditScreen({super.key, required this.user});

  @override
  State<UsersEditScreen> createState() => _UsersEditScreenState();
}

class _UsersEditScreenState extends State<UsersEditScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.user.firstName;
    lastNameController.text = widget.user.lastName;
    emailController.text = widget.user.email;
    phoneController.text = formatNumberToPersianWithoutSeparator(
      widget.user.phone,
    );
    passwordController.text = widget.user.password;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
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
          backgroundColor: AppColors.primary800,
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
              if (value == 'edit') {
              } else if (value == 'delete') {}
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'edit',
                  child: Text(
                    'انتخاب به‌عنوان ادمین',
                    style: TextStyle(
                      color: AppColors.primary800,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text(
                    'حذف کاربر',
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
          title: const Text(
            'ویرایش کاربر',
            style: TextStyle(color: AppColors.white),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            children: [
              InputTextField(label: 'نام', initialValue: firstNameController),
              InputTextField(
                label: 'نام خانوادگی',
                initialValue: lastNameController,
              ),
              InputTextField(label: 'ایمیل', initialValue: emailController),
              InputTextField(label: 'تلفن', initialValue: phoneController),
              InputTextField(
                label: 'رمز عبور',
                initialValue: passwordController,
              ),
              const Spacer(),
              Button(onPressed: () {}, label: 'ویرایش', width: double.infinity),
            ],
          ),
        ),
      ),
    );
  }
}
