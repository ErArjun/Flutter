import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final Function reset;

  const Result(this.score, this.reset);

  String get resultPhrase {
    String resultText;
    if (score <= 8) {
      resultText = 'good';
    } else if (score <= 12) {
      resultText = 'awesome';
    } else if (score <= 16) {
      resultText = 'excellent';
    } else if (score <= 24) {
      resultText = 'plus ultra!';
    } else {
      resultText = 'bad';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () => reset(),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            child: const Text('Restart Quiz!'),
          ),
        ],
      ),
    );
  }
}
