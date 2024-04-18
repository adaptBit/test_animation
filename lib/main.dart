import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_animation/model/score.dart';
import 'package:test_animation/widgets/splitting_container_animate.dart';

void main() {
  runApp(const MainApp());
}

Random random = Random();
List<String> titleList = ['Strong', 'Reused', 'Weak', 'Total'];

int randomNumber() {
    return random.nextInt(101);
}

Color backgroundColor = const Color.fromARGB(255, 255, 255, 255);

List<Score> generateScore() {
    List<Score> result = List.generate(3, (index) {
      return Score(title: titleList[index], score: randomNumber());
    });
    int maxScore = result.map((score) => score.score).reduce((value, element) => value + element);
    result.add(Score(title: titleList[3], score: maxScore));
    return result;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    List<Score> scoreList = generateScore();
    return MaterialApp(
      home: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            scoreList = generateScore();
          },
          child: Container(
            color: backgroundColor,
            height: double.infinity,
            width: 400,
            child: Column(
              children: [
                 Expanded(child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SplittingContainerAnimate(
                    scoreList: scoreList,
                    width: 250,
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}
