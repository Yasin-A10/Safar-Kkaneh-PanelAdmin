import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/models/user_model.dart';

final List<UserModel> users = [
  UserModel(
    id: 1,
    firstName: 'محمد',
    lastName: 'تیموری',
    email: 'mohammad.miladi@gmail.com',
    phone: '09123456789',
    role: 'user',
    password: '123456',
  ),
  UserModel(
    id: 2,
    firstName: 'امیرحسین',
    lastName: 'میلادی',
    email: 'mohammad.miladi@gmail.com',
    phone: '09123456789',
    role: 'user',
    password: '123456',
  ),
  UserModel(
    id: 3,
    firstName: 'محمد',
    lastName: 'جوادی',
    email: 'mohammad.miladi@gmail.com',
    phone: '09123456789',
    role: 'user',
    password: '123456',
  ),
  UserModel(
    id: 4,
    firstName: 'رضا',
    lastName: 'میلادی',
    email: 'mohammad.miladi@gmail.com',
    phone: '09123456789',
    role: 'user',
    password: '123456',
  ),
  UserModel(
    id: 5,
    firstName: 'محمد',
    lastName: 'حسینی',
    email: 'mohammad.miladi@gmail.com',
    phone: '09123456789',
    role: 'user',
    password: '123456',
  ),
];

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () {
              context.pop();
            },
          ),
        ],
        title: const Text('کاربران'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary700,
              child: Text(
                formatNumberToPersian(user.id),
                style: const TextStyle(color: AppColors.white),
              ),
            ),
            title: Text(user.firstName),
            subtitle: Row(
              children: [
                Text(
                  user.lastName,
                  style: const TextStyle(
                    color: AppColors.grey700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  user.email,
                  style: const TextStyle(
                    color: AppColors.grey500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            trailing: const Icon(Iconsax.edit),
            onTap: () {
              context.push('/user/${user.id}', extra: user);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary800,
        foregroundColor: AppColors.white,
        onPressed: () {},
        child: const Icon(Iconsax.add, size: 32),
      ),
    );
  }
}
