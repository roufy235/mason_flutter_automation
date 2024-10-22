import 'package:{{package_name}}/common/providers/common_providers.dart';
import 'package:{{package_name}}/common/providers/invalid_token_provider.dart';
import 'package:{{package_name}}/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class AppRouter {
  final WidgetRef ref;
  GoRouter get router => _goRouter;
  AppRouter({required this.ref});

  late final GoRouter _goRouter = GoRouter(
    initialLocation: '/${AppScreens.onboarding.toPath}',
    refreshListenable: ref.watch(invalidTokenProvider),
    routes: <GoRoute>[
      GoRoute(
        path: '/${AppScreens.onboarding.toPath}',
        name: AppScreens.onboarding.toName,
        builder: (BuildContext context, GoRouterState state) => const OnBoardingScreen(),
      )
    ]
  );
}
