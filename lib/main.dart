import 'package:flutter/material.dart';
import 'package:quizler/quiz_Brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(Quizer());
}

class Quizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: QuizerPage(),
        )),
      ),
    );
  }
}

class QuizerPage extends StatefulWidget {
  @override
  State<QuizerPage> createState() => _QuizerPageState();
}

class _QuizerPageState extends State<QuizerPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finshed',
          desc: 'You\'ve reached the end of quiz.',
        ).show();

        quizBrain.rest();
        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(true);
              },
              child: const Text(
                'True',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                checkAnswer(false);
              },
              child: const Text(
                'False',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
