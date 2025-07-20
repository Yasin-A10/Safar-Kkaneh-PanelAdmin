import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/config/router/app_router.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/number_formater.dart';
import 'package:safar_khaneh_panel/data/api/comment_services.dart';
import 'package:safar_khaneh_panel/data/models/comment_model.dart';
import 'package:safar_khaneh_panel/widgets/search_bar.dart';

class CommentsListScreen extends StatefulWidget {
  const CommentsListScreen({super.key});

  @override
  State<CommentsListScreen> createState() => _CommentsListScreenState();
}

class _CommentsListScreenState extends State<CommentsListScreen> {
  final CommentServices _commentServices = CommentServices();
  late Future<List<CommentModel>> comments;

  @override
  void initState() {
    super.initState();
    comments = _commentServices.fetchComments();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      comments = _commentServices.fetchComments();
    });
  }

  void _handleSearch(String query) async {
    final result = await _commentServices.fetchComments(query: query);
    setState(() {
      comments = Future.value(result);
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
          'لیست نظرات',
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
          future: comments,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('خطا در دریافت نظرات: ${snapshot.error}'),
              );
            }
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('هیچ نظری وجود ندارد'));
            }
            final comments = snapshot.data!;
            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.secondary400,
                    child: Text(
                      formatNumberToPersian(comment.id!),
                      style: const TextStyle(color: AppColors.white),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        comment.user!.fullName!,
                        style: const TextStyle(
                          color: AppColors.grey700,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        comment.residence!.title!,
                        style: const TextStyle(
                          color: AppColors.grey500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    comment.comment!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.grey700,
                      fontSize: 12,
                    ),
                  ),
                  trailing: const Icon(Iconsax.edit),
                  onTap: () {
                    context.push(
                      '/comment/${comment.id}',
                      extra: comment,
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
