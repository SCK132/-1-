// lib/pages/result_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/quiz_state.dart';

class ResultPage extends StatefulWidget {
  final int score;
  const ResultPage({super.key, required this.score});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
    // この画面が表示された時にハイスコアを更新
    quizState.updateHighScore();
  }

  // 正解数に応じて教室番号のウィジェットを生成する
  List<Widget> _buildRoomNumberWidgets(int correctCount) {
    const roomNumber = "61000";
    List<Widget> widgets = [];

    for (int i = 0; i < roomNumber.length; i++) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child:
              i < correctCount
                  ? Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      roomNumber[i],
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  : ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'images/wasedabear.jpg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('クイズ結果'),
        automaticallyImplyLeading: false,
      ),
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
                const Text(
                  '結果発表',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 10.0, color: Colors.black)],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '${quizState.totalQuestions}問中 ${widget.score}問 正解！',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 10.0, color: Colors.black)],
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  '景品は ??号館 ??? 教室！',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 10.0, color: Colors.black)],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildRoomNumberWidgets(widget.score),
                ),
                const SizedBox(height: 30),
                Image.asset('images/yaguchi_doctor.png', height: 150),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => context.go('/home'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: const Text('ホームページへ戻る'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
