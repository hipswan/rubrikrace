// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';

class ResultCheckPainter extends CustomPainter {
  final gridSize;
  final resultColor;
  ResultCheckPainter({this.gridSize, this.resultColor});
  @override
  void paint(Canvas canvas, Size size) {
    var outlineBrush = Paint()
      ..color = resultColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawPath(
        Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              Rect.fromCircle(
                center: const Offset(100, 100),
                radius: 200 / gridSize * ((gridSize - 2) / 2),
              ),
              const Radius.circular(
                4,
              ),
            ),
          )
          ..close(),
        outlineBrush);
  }

  @override
  bool shouldRepaint(ResultCheckPainter oldDelegate) {
    return gridSize != oldDelegate.gridSize ||
        resultColor != oldDelegate.resultColor;
  }
}
