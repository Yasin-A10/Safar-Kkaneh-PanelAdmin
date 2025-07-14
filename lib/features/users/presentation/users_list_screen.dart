import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/config/router/app_router.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/api/user_services.dart';
import 'package:safar_khaneh_panel/data/models/user_model.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  final UserService _userService = UserService();
  late Future<List<UserModel>> users;

  @override
  void initState() {
    super.initState();
    users = _userService.fetchUsers();
  }

  Future<void> _refreshUsers() async {
    setState(() {
      users = _userService.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                GoRouter.of(navigatorKey.currentContext!).go('/menu');
              }
            },
          ),
        ],
        title: const Text('کاربران'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshUsers,
        child: FutureBuilder(
          future: users,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('خطا در دریافت کاربران: ${snapshot.error}'),
              );
            }
            final users = snapshot.data!;
            return ListView.builder(
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
                  title: Text(user.fullName),
                  subtitle: Row(
                    children: [
                      Text(
                        user.email,
                        style: const TextStyle(
                          color: AppColors.grey700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        formatNumberToPersianWithoutSeparator(user.phoneNumber),
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
            );
          },
        ),
      ),
    );
  }
}
