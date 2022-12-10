import 'package:flutter/material.dart';
import 'package:quiz_app/result.dart';
import 'quiz.dart';

//void main() {
//  runApp(MyApp());
//}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': 'what\'s your favourite color?',
      'answers': [
        {'text': 'red', 'score': 10},
        {'text': 'blue', 'score': 7},
        {'text': 'black', 'score': 5},
        {'text': 'yellow', 'score': 6}
      ],
    },
    {
      'questionText': 'what\'s your favourite animal?',
      'answers': [
        {'text': 'Dog', 'score': 4},
        {'text': 'Cat', 'score': 7},
        {'text': 'Lion', 'score': 9},
        {'text': 'Tiger', 'score': 2}
      ],
    },
    {
      'questionText': 'what\'s your favourite sports?',
      'answers': [
        {'text': 'cricket', 'score': 0},
        {'text': 'volleyball', 'score': 4},
        {'text': 'basketball', 'score': 6},
        {'text': 'football', 'score': 8}
      ],
    },
  ];

  var _questionIndex = 0;

  void _answerQuestion() {
    setState(() {
      _questionIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz App'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                questions: _questions,
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex)
            : Result(),
      ),
    );
  }
}
