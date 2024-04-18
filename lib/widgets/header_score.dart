import 'package:flutter/material.dart';

class HeaderScore extends StatelessWidget {
  final int score;
  const HeaderScore({super.key, this.score = 0});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          score.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),
        ),
        const Text(
          'Score',
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}