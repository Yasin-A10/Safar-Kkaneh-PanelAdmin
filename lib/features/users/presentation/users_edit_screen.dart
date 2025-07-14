import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/config/router/app_router.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/convert_to_jalali.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/core/utils/validators.dart';
import 'package:safar_khaneh_panel/data/api/user_services.dart';
import 'package:safar_khaneh_panel/data/models/user_model.dart';
import 'package:safar_khaneh_panel/widgets/button.dart';
import 'package:safar_khaneh_panel/widgets/inputs/text_form_field.dart';

class UsersEditScreen extends StatefulWidget {
  final UserModel user;
  const UsersEditScreen({super.key, required this.user});

  @override
  State<UsersEditScreen> createState() => _UsersEditScreenState();
}

class _UsersEditScreenState extends State<UsersEditScreen> {
  final GlobalKey<FormState> _editUserFormKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final UserService _userService = UserService();

  bool _isAdmin = false;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    fullNameController.text = widget.user.fullName;
    phoneController.text = widget.user.phoneNumber;
    _isAdmin = widget.user.isAdmin;
    _isActive = widget.user.isActive;
  }

  bool _isLoading = false;

  void _handleEditUser(context) async {
    if (!_editUserFormKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });
    try {
      await _userService.updateUser(
        id: widget.user.id,
        fullName: fullNameController.text,
        phoneNumber: phoneController.text,
        isActive: _isActive,
        isAdmin: _isAdmin,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            'ویرایش با موفقیت انجام شد',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: AppColors.success200,
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            'خطا در ویرایش کاربر',
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

  void _handleDeleteUser(context) async {
    try {
      await _userService.deleteUser(widget.user.id);

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
        GoRouter.of(navigatorKey.currentContext!).go('/users');
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text('خطا در حذف کاربر', textDirection: TextDirection.rtl),
          backgroundColor: AppColors.error200,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
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
              if (value == 'delete') {
                _handleDeleteUser(context);
              }
            },
            itemBuilder: (context) {
              return [
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
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Form(
                  key: _editUserFormKey,
                  child: Column(
                    spacing: 16,
                    children: [
                      InputTextFormField(
                        label: 'نام و نام خانوادگی',
                        controller: fullNameController,
                        validator: (value) {
                          return AppValidator.userName(value);
                        },
                      ),
                      InputTextFormField(
                        label: 'شماره همراه',
                        controller: phoneController,
                        validator: (value) {
                          return AppValidator.phoneNumber(value);
                        },
                      ),
                      Row(
                        children: [
                          const Text('فعال', style: TextStyle(fontSize: 16)),
                          const Spacer(),
                          Transform.scale(
                            scale: 0.85,
                            child: Switch(
                              value: _isActive,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isActive = value ?? false;
                                });
                              },
                              inactiveThumbColor: AppColors.grey400,
                              activeColor: AppColors.primary800,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('ادمین', style: TextStyle(fontSize: 16)),
                          const Spacer(),
                          Transform.scale(
                            scale: 0.85,
                            child: Switch(
                              value: _isAdmin,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isAdmin = value ?? false;
                                });
                              },
                              inactiveThumbColor: AppColors.grey400,
                              activeColor: AppColors.primary800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.success200, width: 1.5),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.message,
                                color: AppColors.grey400,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'ایمیل',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.grey400,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.user.email,
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
                                Iconsax.calendar_tick,
                                color: AppColors.grey400,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'تاریخ ایجاد',
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
                              convertToJalaliDate(widget.user.createdAt),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(color: AppColors.success200, thickness: 1),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.wallet,
                                color: AppColors.grey400,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'حساب کاربر',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.grey400,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            formatNumberToPersian(widget.user.walletBalance),
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
                                Iconsax.profile_tick,
                                color: AppColors.grey400,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'تایید ایمیل؟',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.grey400,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            widget.user.isEmailVerified
                                ? Iconsax.tick_circle
                                : Iconsax.close_circle,
                            color: widget.user.isEmailVerified
                                ? AppColors.success200
                                : AppColors.error200,
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
            onPressed: () {
              _handleEditUser(context);
            },
            label: 'ویرایش',
            width: double.infinity,
            isLoading: _isLoading,
            enabled: !_isLoading,
          ),
        ),
      ),
    );
  }
}
