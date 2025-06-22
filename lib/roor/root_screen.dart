import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';

class RootScreen extends StatefulWidget {
  final Widget child;

  const RootScreen({super.key, required this.child});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;
  String _appBarTitle = 'داشبورد';

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _appBarTitle = 'داشبورد';
          context.push('/dashboard');
          break;
        case 1:
          _appBarTitle = 'منو';
          context.push('/menu');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // تشخیص مسیر فعلی
    final location = GoRouter.of(context).state.uri.toString();

    // تعیین ایندکس و عنوان جدید بر اساس مسیر
    int newIndex = 0;
    String newTitle = 'داشبورد';

    if (location == '/menu') {
      newIndex = 1;
      newTitle = 'منو';
    }

    // به‌روزرسانی وضعیت اگر لازم باشد
    if (newIndex != _currentIndex || newTitle != _appBarTitle) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _currentIndex = newIndex;
          _appBarTitle = newTitle;
        });
      });
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_appBarTitle),
          actions: [
            if (_currentIndex == 0)
              IconButton(
                icon: const Icon(Iconsax.logout),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: const Text(
                          'آیا از خروج خود مطمئن هستید؟',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                onPressed: () => context.pop(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.error300,
                                  foregroundColor: AppColors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Vazir',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                child: const Text('بازگشت'),
                              ),
                              SizedBox(width: 16),
                              OutlinedButton(
                                onPressed: () => context.go('/login'),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: AppColors.primary800,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                ),
                                child: const Text(
                                  'بله',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            else
              IconButton(
                icon: const Icon(Iconsax.arrow_left),
                onPressed: () => context.pop(),
              ),
          ],
        ),
        body: widget.child,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
          type: BottomNavigationBarType.shifting,
          iconSize: 28,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.box_1),
              activeIcon: Icon(Iconsax.box_1),
              label: 'داشبورد',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.menu_board),
              activeIcon: Icon(Iconsax.menu_board5),
              label: 'منو',
            ),
          ],
        ),
      ),
    );
  }
}
