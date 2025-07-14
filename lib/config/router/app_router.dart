import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safar_khaneh_panel/config/router/route_paths.dart';
import 'package:safar_khaneh_panel/core/network/secure_token_storage.dart';
import 'package:safar_khaneh_panel/data/models/request_model.dart';
import 'package:safar_khaneh_panel/data/models/reservation_model.dart';
import 'package:safar_khaneh_panel/data/models/residence_model.dart';
import 'package:safar_khaneh_panel/data/models/user_model.dart';
import 'package:safar_khaneh_panel/features/auth/presentation/login_screen.dart';
import 'package:safar_khaneh_panel/features/auth/presentation/register_screen.dart';
import 'package:safar_khaneh_panel/features/discount/presentation/discount_screen.dart';
import 'package:safar_khaneh_panel/features/request/presentation/request_detail_screen.dart';
import 'package:safar_khaneh_panel/features/request/presentation/request_screen.dart';
import 'package:safar_khaneh_panel/features/reservations/presentation/reservations_detail_screen.dart';
import 'package:safar_khaneh_panel/features/reservations/presentation/reservations_list_screen.dart';
import 'package:safar_khaneh_panel/features/residences/presentation/residences_edit_screen.dart';
import 'package:safar_khaneh_panel/features/residences/presentation/residences_list_screen.dart';
import 'package:safar_khaneh_panel/features/transactions/presentation/transaction_detail_screen.dart';
import 'package:safar_khaneh_panel/features/transactions/presentation/transaction_list_screen.dart';
import 'package:safar_khaneh_panel/features/users/presentation/users_edit_screen.dart';
import 'package:safar_khaneh_panel/roor/not_found_screen.dart';
import 'package:safar_khaneh_panel/roor/root_screen.dart';
import 'package:safar_khaneh_panel/features/dashboard/presentation/dashboard_screen.dart';
import 'package:safar_khaneh_panel/features/menu/presentation/menu_screen.dart';
import 'package:safar_khaneh_panel/features/users/presentation/users_list_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final List<RegExp> publicRoutePatterns = [RegExp(r'^/login$')];

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: RoutePaths.dashboard,
  routes: [
    GoRoute(
      path: RoutePaths.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RoutePaths.register,
      builder: (context, state) => const RegisterScreen(),
    ),

    GoRoute(
      path: RoutePaths.users,
      builder: (context, state) => const UsersListScreen(),
    ),
    GoRoute(
      path: RoutePaths.user,
      builder: (context, state) {
        final user = state.extra as UserModel;
        return UsersEditScreen(user: user);
      },
    ),

    GoRoute(
      path: RoutePaths.residences,
      builder: (context, state) => const ResidencesListScreen(),
    ),
    GoRoute(
      path: RoutePaths.residence,
      builder: (context, state) {
        final residence = state.extra as ResidenceModel;
        return ResidencesEditScreen(residence: residence);
      },
    ),

    GoRoute(
      path: RoutePaths.reservations,
      builder: (context, state) => const ReservationsListScreen(),
    ),
    GoRoute(
      path: RoutePaths.reservation,
      builder: (context, state) {
        final reservation = state.extra as ReservationModel;
        return ReservationsDetailScreen(reservation: reservation);
      },
    ),

    GoRoute(
      path: RoutePaths.transactions,
      builder: (context, state) => const TransactionsListScreen(),
    ),
    GoRoute(
      path: RoutePaths.transaction,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>; // دریافت به‌صورت Map
        final transaction =
            extra['transaction']
                as TransactionModel; // استخراج TransactionModel
        final reservations =
            extra['reservations']
                as List<ReservationModel>; // استخراج لیست رزروها
        return TransactionDetailScreen(
          transaction: transaction,
          reservations: reservations,
        );
      },
    ),

    GoRoute(
      path: RoutePaths.discounts,
      builder: (context, state) => const DiscountScreen(),
    ),

    GoRoute(
      path: RoutePaths.requests,
      builder: (context, state) => const RequestScreen(),
    ),
    GoRoute(
      path: RoutePaths.request,
      builder: (context, state) {
        final request = state.extra as RequestModel;
        return RequestDetailScreen(request: request);
      },
    ),

    ShellRoute(
      builder: (context, state, child) => RootScreen(child: child),
      routes: [
        GoRoute(
          path: RoutePaths.dashboard,
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: RoutePaths.menu,
          builder: (context, state) => const MenuScreen(),
        ),
      ],
    ),
  ],
  redirect: (context, state) async {
    final isLoggedIn = await TokenStorage.hasAccessToken();
    final currentPath = state.matchedLocation;

    final isPublicRoute = publicRoutePatterns.any(
      (pattern) => pattern.hasMatch(currentPath),
    );

    if (!isLoggedIn && !isPublicRoute) return '/login';
    if (isLoggedIn && currentPath == '/login') return '/dashboard';
    return null;
  },

  errorBuilder: (context, state) => const NotFoundScreen(),
);
