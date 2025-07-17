import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/convert_to_jalali.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/api/transaction_services.dart';
import 'package:safar_khaneh_panel/data/models/transaction_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
