// lib/main.dart
import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_state.dart';
import 'package:quiz_app/router/router.dart';

// main関数をFuture<void>に変更し、async/awaitを使えるようにする
Future<void> main() async {
  // runAppの前にFlutterの初期化を保証する
  WidgetsFlutterBinding.ensureInitialized();
  // アプリ起動時にSharedPreferencesからデータを読み込む
  await quizState.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'アプリ班1年企画',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.transparent, // 背景画像が見えるように透明に
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 1,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      routerConfig: router,
    );
  }
}
