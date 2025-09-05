// lib/router/router.dart
import 'package:go_router/go_router.dart';
import 'package:quiz_app/pages/home_page.dart';
import 'package:quiz_app/pages/quiz_page.dart';
import 'package:quiz_app/pages/result_page.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/quiz/:difficulty', // 難易度をパスパラメータで受け取る
      name: 'quiz',
      builder: (context, state) {
        final difficulty = state.pathParameters['difficulty']!;
        return QuizPage(difficulty: difficulty);
      },
    ),
    GoRoute(
      path: '/result',
      name: 'result',
      builder: (context, state) {
        // extraからスコアを受け取る
        final score = state.extra as int;
        return ResultPage(score: score);
      },
    ),
  ],
);
