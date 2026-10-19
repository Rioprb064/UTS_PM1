import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../state/quiz_controller.dart';
import '../screens/quiz_screen.dart';
import '../screens/name_screen.dart';
import '../screens/home_screen.dart';
import '../screens/result_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final quiz = context.read<QuizController>();
    final route = state.matchedLocation;

    if (quiz.userName.isEmpty && route != '/') return '/';
    if (route == '/result' && !quiz.isComplete) return '/quiz';
    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const NameScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/quiz', builder: (context, state) => const QuizScreen()),
    GoRoute(path: '/result', builder: (context, state) => const ResultScreen()),
  ],
);
