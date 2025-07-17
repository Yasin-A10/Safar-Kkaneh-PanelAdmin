import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/config/router/app_router.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/api/residence_services.dart';
import 'package:safar_khaneh_panel/data/models/residence_model.dart';
import 'package:safar_khaneh_panel/widgets/search_bar.dart';

class ResidencesListScreen extends StatefulWidget {
  const ResidencesListScreen({super.key});

  @override
  State<ResidencesListScreen> createState() => _ResidencesListScreenState();
}

class _ResidencesListScreenState extends State<ResidencesListScreen> {
  final ResidenceServices _residenceServices = ResidenceServices();
  late Future<List<ResidenceModel>> residences;

  @override
  void initState() {
    super.initState();
    residences = _residenceServices.fetchConfirmedResidences();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      residences = _residenceServices.fetchConfirmedResidences();
    });
  }

  void _handleSearch(String query) async {
    final result = await _residenceServices.fetchConfirmedResidences(
      query: query,
    );
    setState(() {
      residences = Future.value(result);
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
          'لیست اقامتگاه ها',
          style: TextStyle(color: AppColors.secondary500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left, color: AppColors.secondary500),
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
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: FutureBuilder(
          future: residences,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('خطا در دریافت اقامتگاه ها: ${snapshot.error}'),
              );
            }
            final residences = snapshot.data!;
            return ListView.builder(
              itemCount: residences.length,
              itemBuilder: (context, index) {
                final residence = residences[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.secondary400,
                    child: Text(
                      formatNumberToPersian(residence.id!),
                      style: const TextStyle(color: AppColors.white),
                    ),
                  ),
                  title: Text(residence.title!),
                  subtitle: Row(
                    children: [
                      Text(
                        'مدیر: ${residence.owner!.fullName}',
                        style: const TextStyle(
                          color: AppColors.grey700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '${residence.location!.city!.name}، ${residence.location!.city!.province!.name}',
                        style: const TextStyle(
                          color: AppColors.grey500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Iconsax.edit),
                  onTap: () {
                    context.push(
                      '/residence/${residence.id}',
                      extra: residence,
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
