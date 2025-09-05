// lib/router/quiz_shell.dart
import 'package:flutter/material.dart';

class QuizShell extends StatelessWidget {
  final Widget child;
  final int questionIndex;

  const QuizShell({
    super.key,
    required this.child,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // bodyをAppBarの背後まで広げる
      appBar: AppBar(
        title: Text('第 ${questionIndex + 1} 問'),
        automaticallyImplyLeading: false, // 戻るボタンを非表示
      ),
      // Stackを使って背景画像とコンテンツを重ねる
      body: Stack(
        children: [
          // 背景画像
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/home.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // クイズのコンテンツ（QuizPage）
          SafeArea(child: child),
        ],
      ),
      // 要件10: 下のバーは削除
    );
  }
}
