import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/convert_to_jalali.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/api/transaction_services.dart';
import 'package:safar_khaneh_panel/data/models/transaction_model.dart';
import 'package:safar_khaneh_panel/widgets/button.dart';
import 'package:safar_khaneh_panel/widgets/search_bar.dart';

class TransactionsListScreen extends StatefulWidget {
  const TransactionsListScreen({super.key});

  @override
  State<TransactionsListScreen> createState() => _TransactionsListScreenState();
}

class _TransactionsListScreenState extends State<TransactionsListScreen> {
  final TransactionService _transactionService = TransactionService();
  late Future<List<TransactionModel>> _transactions;

  String _getTransactionTitle(TransactionModel transaction) {
    switch (transaction.type) {
      case 'topup':
        return 'شارژ کیف پول';
      case 'online':
        return 'پرداخت آنلاین رزرو';
      case 'cash':
        return 'پرداخت نقدی رزرو';
      case 'wallet':
        return 'پرداخت از کیف پول';
      case 'refund':
        return 'بازگشت وجه به کیف پول';
      case 'payout':
        return 'تسویه با مالک';
      default:
        return 'تراکنش';
    }
  }

  String _getTransactionPrice(TransactionModel transaction) {
    switch (transaction.type) {
      case 'topup':
        return formatNumberToPersian(transaction.amount);
      case 'online':
        return formatNumberToPersian(transaction.reservation!.totalPrice ?? 0);
      case 'cash':
        return formatNumberToPersian(transaction.reservation!.totalPrice ?? 0);
      case 'wallet':
        return formatNumberToPersian(transaction.reservation!.totalPrice ?? 0);
      case 'refund':
        return formatNumberToPersian(transaction.amount);
      case 'payout':
        return formatNumberToPersian(transaction.amount);
      default:
        return '0';
    }
  }

  String? _selectedStatus;
  String? _selectedType;

  final List<Map<String, String>> statusOptions = [
    {'label': 'تایید شده', 'value': 'confirmed'},
    {'label': 'در انتظار تایید', 'value': 'pending'},
    {'label': 'لغو شده', 'value': 'cancelled'},
  ];

  final List<Map<String, String>> typeOptions = [
    {'label': 'پرداخت آنلاین', 'value': 'online'},
    {'label': 'پرداخت با کیف پول', 'value': 'wallet'},
    {'label': 'پرداخت نقدی', 'value': 'cash'},
    {'label': 'شارژ کیف پول', 'value': 'topup'},
    {'label': 'بازگشت وجه به کیف پول', 'value': 'refund'},
    {'label': 'تسویه با مالک', 'value': 'payout'},
  ];

  @override
  void initState() {
    super.initState();
    _transactions = _transactionService.fetchTransactions();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _transactions = _transactionService.fetchTransactions();
    });
  }

  void _handleSearch(String query) async {
    final result = await _transactionService.fetchTransactions(query: query);
    setState(() {
      _transactions = Future.value(result);
    });
  }

  void _handleFilter(String? status, String? type) async {
    final result = await _transactionService.fetchTransactions(
      status: status,
      type: type,
    );
    setState(() {
      _transactions = Future.value(result);
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'انتخاب وضعیت',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...statusOptions.map((option) {
                        return RadioListTile<String>(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          visualDensity: const VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                          title: Text(option['label']!),
                          value: option['value']!,
                          groupValue: _selectedStatus,
                          onChanged: (value) {
                            setModalState(() {
                              if (_selectedStatus == value) {
                                _selectedStatus = null;
                              } else {
                                _selectedStatus = value;
                              }
                            });
                          },
                        );
                      }),
                      const SizedBox(height: 32),
                      const Text(
                        'انتخاب نوع پرداخت',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...typeOptions.map((option) {
                        return RadioListTile<String>(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          visualDensity: const VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                          title: Text(option['label']!),
                          value: option['value']!,
                          groupValue: _selectedType,
                          onChanged: (value) {
                            setModalState(() {
                              if (_selectedType == value) {
                                _selectedType = null;
                              } else {
                                _selectedType = value;
                              }
                            });
                          },
                        );
                      }),
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
                            _handleFilter(_selectedStatus, _selectedType);
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
        title: const Text(
          'تراکنش ها',
          style: TextStyle(color: AppColors.warning150),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left, color: AppColors.warning150),
            onPressed: () {
              context.pop();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: FutureBuilder(
          future: _transactions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('خطا: ${snapshot.error}'));
            }
            final transactions = snapshot.data!;
            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.warning150,
                    child: Text(
                      formatNumberToPersian(transaction.id),
                      style: const TextStyle(color: AppColors.white),
                    ),
                  ),
                  title: Text(_getTransactionTitle(transaction)),
                  subtitle: Row(
                    children: [
                      Text(
                        transaction.user.fullName,
                        style: const TextStyle(
                          color: AppColors.grey700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        formatNumberToPersianWithoutSeparator(
                          convertToJalaliDate(transaction.createdAt),
                        ),
                        style: const TextStyle(
                          color: AppColors.grey500,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        _getTransactionPrice(transaction),
                        style: TextStyle(
                          color: transaction.status == 'confirmed'
                              ? AppColors.success200
                              : AppColors.error300,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Iconsax.eye),
                  onTap: () {
                    context.push(
                      '/transaction/${transaction.id}',
                      extra: transaction,
                    );
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
