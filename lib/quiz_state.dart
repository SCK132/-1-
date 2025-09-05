// lib/quiz_state.dart
import 'package:shared_preferences/shared_preferences.dart';

class QuizState {
  static final QuizState _instance = QuizState._internal();
  factory QuizState() => _instance;
  QuizState._internal();

  late SharedPreferences _prefs;

  int score = 0;
  final int totalQuestions = 5;
  String difficulty = 'easy';

  int _highScore = 0;
  int get highScore => _highScore;

  bool _isPrizeClaimed = false;
  bool get isPrizeClaimed => _isPrizeClaimed;

  // アプリ起動時にデータを読み込む
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _highScore = _prefs.getInt('highScore') ?? 0;
    _isPrizeClaimed = _prefs.getBool('isPrizeClaimed') ?? false;
  }

  void incrementScore() {
    score++;
  }

  void reset() {
    score = 0;
  }

  // ハイスコアを更新して保存
  Future<void> updateHighScore() async {
    if (score > _highScore) {
      _highScore = score;
      await _prefs.setInt('highScore', _highScore);
    }
  }

  // 景品受け取り状態を保存
  Future<void> claimPrize() async {
    _isPrizeClaimed = true;
    await _prefs.setBool('isPrizeClaimed', true);
  }
}

final quizState = QuizState();
