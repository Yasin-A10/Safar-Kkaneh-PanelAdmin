import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/convert_to_jalali.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/features/discount/create_discount_form.dart';
import 'package:safar_khaneh_panel/data/models/discount_model.dart';
import 'package:safar_khaneh_panel/data/api/discount_services.dart';
import 'package:safar_khaneh_panel/widgets/search_bar.dart';

class DiscountScreen extends StatefulWidget {
  const DiscountScreen({super.key});

  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  final DiscountService _discountService = DiscountService();
  late Future<List<DiscountModel>> _discounts;

  @override
  void initState() {
    super.initState();
    _discounts = _discountService.fetchDiscounts();
  }

  void _handleDeleteDiscount(context, int id) async {
    try {
      await _discountService.deleteDiscount(id);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('تخفیف با موفقیت حذف شد')));
      setState(() {
        _discounts = _discountService.fetchDiscounts();
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('خطا در حذف تخفیف: $e')));
    }
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _discounts = _discountService.fetchDiscounts();
    });
  }

  void _handleSearch(String query) async {
    final result = await _discountService.fetchDiscounts(query: query);
    setState(() {
      _discounts = Future.value(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
          title: const Text(
            'تخفیف ها',
            style: TextStyle(color: Colors.deepPurple),
          ),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.arrow_left, color: Colors.deepPurple),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
        body: Container(
          child: RefreshIndicator(
            onRefresh: _handleRefresh,
            child: FutureBuilder(
              future: _discounts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'خطا در دریافت لیست تخفیف ها: ${snapshot.error}',
                    ),
                  );
                }
                final discounts = snapshot.data!;
                return ListView.builder(
                  itemCount: discounts.length,
                  itemBuilder: (context, index) {
                    final discount = discounts[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: Text(
                          formatNumberToPersian(discount.id),
                          style: const TextStyle(color: AppColors.white),
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(discount.title),
                          const SizedBox(width: 4),
                          Text('.'),
                          const SizedBox(width: 4),
                          Text(
                            discount.code,
                            style: TextStyle(color: AppColors.grey600),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            '${formatNumberToPersian(discount.discountPercentage)}% تخفیف',
                            style: const TextStyle(
                              color: AppColors.grey700,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '${formatNumberToPersianWithoutSeparator(convertToJalaliDate(discount.startDate))} - ${formatNumberToPersianWithoutSeparator(convertToJalaliDate(discount.endDate))}',
                            style: const TextStyle(
                              color: AppColors.grey500,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Iconsax.trash, color: AppColors.error300),
                        onPressed: () {
                          _handleDeleteDiscount(context, discount.id);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          foregroundColor: AppColors.white,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const CreateDiscountForm(),
              ),
            );
          },

          child: const Icon(Iconsax.add, size: 32),
        ),
      ),
    );
  }
}
