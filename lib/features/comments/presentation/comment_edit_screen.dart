import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh_panel/config/router/app_router.dart';
import 'package:safar_khaneh_panel/core/constants/colors.dart';
import 'package:safar_khaneh_panel/core/utils/validators.dart';
import 'package:safar_khaneh_panel/data/api/comment_services.dart';
import 'package:safar_khaneh_panel/data/models/comment_model.dart';
import 'package:safar_khaneh_panel/widgets/button.dart';
import 'package:safar_khaneh_panel/widgets/inputs/text_form_field.dart';

class CommentDetailScreen extends StatefulWidget {
  final CommentModel comment;
  const CommentDetailScreen({super.key, required this.comment});

  @override
  State<CommentDetailScreen> createState() => _CommentDetailScreenState();
}

class _CommentDetailScreenState extends State<CommentDetailScreen> {
  final GlobalKey<FormState> _editCommentFormKey = GlobalKey<FormState>();

  final CommentServices _commentServices = CommentServices();
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    commentController.text = widget.comment.comment!;
    super.initState();
  }

  bool _isLoading = false;

  void _handleEditComment(context) async {
    if (!_editCommentFormKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });
    try {
      await _commentServices.updateComment(
        widget.comment.id!,
        commentController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            'ویرایش با موفقیت انجام شد',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: AppColors.success200,
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text('خطا در ویرایش نظر', textDirection: TextDirection.rtl),
          backgroundColor: AppColors.error200,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleDeleteComment(context) async {
    try {
      await _commentServices.deleteComment(widget.comment.id!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            'حذف با موفقیت انجام شد',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: AppColors.success200,
          duration: const Duration(milliseconds: 1800),
        ),
      );

      Future.delayed(const Duration(milliseconds: 1900), () {
        GoRouter.of(navigatorKey.currentContext!).go('/comments');
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text('خطا در حذف نظر', textDirection: TextDirection.rtl),
          backgroundColor: AppColors.error200,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary800,
          automaticallyImplyLeading: false,
          leading: PopupMenuButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              side: BorderSide(color: AppColors.white, width: 2),
            ),
            elevation: 8,
            offset: const Offset(0, 48),
            icon: const Icon(Iconsax.menu, color: AppColors.white),
            onSelected: (value) {
              if (value == 'deleteComment') {
                _handleDeleteComment(context);
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'deleteComment',
                  child: Text(
                    'حذف نظر',
                    style: TextStyle(
                      color: AppColors.error300,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ];
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.arrow_left, color: AppColors.white),
              onPressed: () {
                context.pop();
              },
            ),
          ],
          title: const Text(
            'ویرایش کاربر',
            style: TextStyle(color: AppColors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _editCommentFormKey,
              child: Column(
                spacing: 16,
                children: [
                  InputTextFormField(
                    label: 'متن نظر',
                    controller: commentController,
                    maxLines: 5,
                    minLines: 4,
                    validator: (value) {
                      return AppValidator.userName(value, fieldName: 'نظر');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 20,
            top: 12,
          ),
          decoration: const BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -4),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Button(
            onPressed: () {
              _handleEditComment(context);
            },
            label: 'ویرایش',
            width: double.infinity,
            isLoading: _isLoading,
            enabled: !_isLoading,
          ),
        ),
      ),
    );
  }
}
