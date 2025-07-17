import 'package:flutter/material.dart';
import 'package:safar_khaneh_panel/config/router/app_router.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/data/api/request_services.dart';
import 'package:safar_khaneh_panel/data/models/residence_model.dart';
import 'package:safar_khaneh_panel/widgets/search_bar.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final RequestServices _requestServices = RequestServices();
  late Future<List<ResidenceModel>> _requests;

  @override
  void initState() {
    _requests = _requestServices.fetchPendingResidences();
    super.initState();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _requests = _requestServices.fetchPendingResidences();
    });
  }

  void _handleSearch(String query) async {
    final result = await _requestServices.fetchPendingResidences(query: query);
    setState(() {
      _requests = Future.value(result);
    });
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
          'درخواست‌های ثبت اقامتگاه',
          style: TextStyle(color: AppColors.grey800),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left, color: AppColors.grey800),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                GoRouter.of(navigatorKey.currentContext!).go('/menu');
              }
            },
          ),
        ],
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: FutureBuilder(
            future: _requests,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('خطا در دریافت درخواست: ${snapshot.error}'),
                );
              }
              final requests = snapshot.data!;
              return ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.grey900,
                      child: Text(
                        formatNumberToPersian(request.id!),
                        style: const TextStyle(color: AppColors.white),
                      ),
                    ),
                    title: Text(request.title!),
                    subtitle: Row(
                      children: [
                        Text(
                          'مدیر: ${request.owner?.fullName}',
                          style: const TextStyle(
                            color: AppColors.grey700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '${request.location?.city?.name}، ${request.location?.city?.province?.name}',
                          style: const TextStyle(
                            color: AppColors.grey500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(Iconsax.eye, color: AppColors.grey800),
                    onTap: () {
                      context.push('/request/${request.id}', extra: request);
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
