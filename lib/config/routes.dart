
import 'package:go_router/go_router.dart';

import '../screens/name_screen.dart';
import '../screens/home_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',

  redirect: (context, state) {
    final name = state.extra;

    if (state.matchedLocation == '/home' &&
        (name is! String || name.trim().isEmpty)) {
      return '/';
    }

    return null;
  },

  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const NameScreen(),
    ),

    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
