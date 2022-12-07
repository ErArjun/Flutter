import 'package:flutter/material.dart';
import 'package:quiz_app/answer.dart';
import 'question.dart';

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
  var _questionIndex = 0;

  void _answerQuestion() {
    setState(() {
      _questionIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    const questions = [
      {
        'questionText': 'what\'s your favourite color?',
        'answers': ['red', 'blue', 'black', 'yellow'],
      },
      {
        'questionText': 'what\'s your favourite animal?',
        'answers': ['Dog', 'Cat', 'Lion', 'tiger'],
      },
      {
        'questionText': 'what\'s your favourite sports?',
        'answers': ['Cricket', 'Volleyball', 'basketball', 'football'],
      },
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz App'),
        ),
        body: Column(
          children: <Widget>[
            Question(questions[_questionIndex]['questionText'].toString()),
            ...(questions[_questionIndex]['answers'] as List<String>)
                .map((answer) {
              return Answer(_answerQuestion, answer);
            }).toList(),
          ],
        ),
      ),
    );
  }
}
