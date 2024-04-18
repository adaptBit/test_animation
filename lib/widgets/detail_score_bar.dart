import 'package:flutter/material.dart';

class DetailScoreBar extends StatelessWidget {
  final String title;
  final int score;
  final int maxScore;
  final double width;
  const DetailScoreBar({
    super.key, 
    required this.title, 
    required this.score, 
    this.width = 0,  
    this.maxScore = 100
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromRGBO(142, 173, 246, 1);
    Color barColor = const Color.fromRGBO(252, 253, 254, 1);
    const barHeight = 8.0;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
              Text(
                score.toString(),
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            ],
          ),
          const SizedBox(height: 4,),
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: barHeight,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
              Container(
                width: (score * width) / maxScore,
                height: barHeight,
                decoration: BoxDecoration(
                  color: barColor,
                  borderRadius: BorderRadius.circular(12)
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}