import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/config/router/app_router.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/api/user_services.dart';
import 'package:safar_khaneh_panel/data/models/user_model.dart';
import 'package:safar_khaneh_panel/widgets/button.dart';
import 'package:safar_khaneh_panel/widgets/search_bar.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  final UserService _userService = UserService();
  late Future<List<UserModel>> users;

  bool _isAdmin = false;

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

  void _handleSearch(String query) async {
    final result = await _userService.fetchUsers(query: query);
    setState(() {
      users = Future.value(result);
    });
  }

  void _handleFilter(bool? isAdmin) async {
    setState(() {
      users = _userService.fetchUsers(isAdmin: isAdmin == true ? true : null);
    });
  }

  void showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'فیلترها',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary800,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      const Text(
                        'فقط کاربران ادمین',
                        style: TextStyle(fontSize: 14),
                      ),
                      const Spacer(),
                      Transform.scale(
                        scale: 0.85,
                        child: Switch(
                          value: _isAdmin,
                          onChanged: (bool? value) {
                            setModalState(() {
                              _isAdmin = value ?? false;
                            });
                          },
                          inactiveThumbColor: AppColors.grey400,
                          activeColor: AppColors.primary800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () => context.pop(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.error200, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          'بازگشت',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.error200,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Button(
                          label: 'اعمال فیلتر',
                          onPressed: () {
                            _handleFilter(_isAdmin);
                            context.pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Iconsax.filter),
                  onPressed: () {
                    showFilterDialog(context);
                  },
                ),
                Expanded(
                  child: CustomSearchBar(
                    onSearch: _handleSearch,
                    hintText: 'جستجو...',
                  ),
                ),
              ],
            ),
          ),
        ),
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
