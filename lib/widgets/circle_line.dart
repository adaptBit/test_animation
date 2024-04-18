import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircleLine extends StatelessWidget {
  final double width;
  final double height;
  final double startAngle;
  const CircleLine({
    super.key, 
    this.width = 200, 
    this.height = 200, 
    this.startAngle = 0
  });

  @override
  Widget build(BuildContext context) {
    return Center(
          child: SizedBox(
            width: width,
            height: height,
            child: CustomPaint(
              painter: CircleLinePainter(
                startAngle: startAngle
              ),
            ),
          ),
        );
  }
}

double degreesToRadians(double degrees) {
  return degrees * (math.pi / 180.0);
}

class CircleLinePainter extends CustomPainter {
  final double startAngle;
  final double curveLength = math.pi * 2;

  CircleLinePainter({
   this.startAngle = 0,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.5
      ..strokeCap = StrokeCap.round; 

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 ;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      degreesToRadians(startAngle), // Start angle
      curveLength * 0.82, // length, full length is math.pi * 2
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}