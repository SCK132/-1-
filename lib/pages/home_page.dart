// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/quiz_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 景品受け取りボタンが押されたときの処理
  void _onClaimPrize() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('確認'),
            content: const Text('景品を受け取ります。この操作は一度しかできません。本当によろしいですか？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('いいえ'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    quizState.claimPrize();
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('景品を受け取りました！')));
                },
                child: const Text('はい'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('アプリ班1年企画')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/home.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'images/yaguchi_quiz.png',
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.quiz,
                      size: 150,
                      color: Colors.grey,
                    );
                  },
                ),
                const SizedBox(height: 40),
                // --- 難易度選択ボタン ---
                ElevatedButton(
                  onPressed: () {
                    quizState.reset();
                    context.go('/quiz/easy');
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('かんたん'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    quizState.reset();
                    context.go('/quiz/hard');
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('むずかしい'),
                ),
                const SizedBox(height: 40),
                // --- 最高記録と景品 ---
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          '🎉 今までの一番良い結果 🎉',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${quizState.highScore} / ${quizState.totalQuestions} 問正解',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed:
                              quizState.isPrizeClaimed ? null : _onClaimPrize,
                          icon: Icon(
                            quizState.isPrizeClaimed
                                ? Icons.check
                                : Icons.card_giftcard,
                          ),
                          label: Text(
                            quizState.isPrizeClaimed ? '景品受け取り済み' : '景品を受け取る',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            disabledBackgroundColor: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
