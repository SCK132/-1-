// lib/pages/quiz_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/data/quiz_data.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/quiz_state.dart';

class QuizPage extends StatefulWidget {
  final String difficulty;
  const QuizPage({super.key, required this.difficulty});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<Quiz> _quizzes;
  int _currentQuestionIndex = 0;
  String? _selectedAnswer;
  bool _isAnswered = false;

  @override
  void initState() {
    super.initState();
    _quizzes = widget.difficulty == 'easy' ? easyQuizzes : hardQuizzes;
    // 問題をシャッフルしたい場合は次の行のコメントを外す
    // _quizzes.shuffle();
  }

  void _selectAnswer(String answer) {
    if (_isAnswered) return;
    setState(() {
      _selectedAnswer = answer;
    });
  }

  void _submitAnswer() {
    if (_selectedAnswer == null) return;
    setState(() {
      _isAnswered = true;
    });

    final currentQuiz = _quizzes[_currentQuestionIndex];
    final isCorrect = _selectedAnswer == currentQuiz.correctAnswer;
    if (isCorrect) {
      quizState.incrementScore();
    }

    _showResultDialog(isCorrect);
  }

  void _showResultDialog(bool isCorrect) {
    showDialog(
      context: context,
      barrierDismissible: false, // ダイアログの外側をタップしても閉じない
      builder:
          (context) => AlertDialog(
            title: Text(
              isCorrect ? '正解！' : '不正解！',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isCorrect ? Colors.red : Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  isCorrect
                      ? 'images/yaguchi_maru.png'
                      : 'images/yaguchi_batsu.png',
                  height: 150,
                ),
                const SizedBox(height: 16),
                Text(
                  '正解は「${_quizzes[_currentQuestionIndex].correctAnswer}」',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: _goToNextQuestion,
                  child: Text(
                    _currentQuestionIndex < quizState.totalQuestions - 1
                        ? '次の問題へ'
                        : '結果を見る',
                  ),
                ),
              ),
            ],
          ),
    );
  }

  void _goToNextQuestion() {
    Navigator.of(context).pop(); // ダイアログを閉じる
    if (_currentQuestionIndex < quizState.totalQuestions - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
        _isAnswered = false;
      });
    } else {
      // 最終問題が終わったら結果ページへ
      context.go('/result', extra: quizState.score);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuiz = _quizzes[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('第${_currentQuestionIndex + 1}問'),
        automaticallyImplyLeading: false, // 戻るボタンを非表示
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/home.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 問題文
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  currentQuiz.question,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),

              // 選択肢
              ...currentQuiz.options.map((option) {
                final isSelected = _selectedAnswer == option;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ElevatedButton(
                    onPressed: () => _selectAnswer(option),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isSelected ? Colors.orangeAccent : Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: Text(option),
                  ),
                );
              }).toList(),
              const SizedBox(height: 30),

              // 解答ボタン
              if (!_isAnswered)
                ElevatedButton(
                  onPressed: _selectedAnswer != null ? _submitAnswer : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('解答する'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
