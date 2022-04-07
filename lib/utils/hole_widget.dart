// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/controller/game_controller.dart';

class HoleWidget extends StatelessWidget {
  const HoleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameController = Provider.of<GameController>(context);
    return SizedBox(
      height: 200.0,
      width: 200.0,
      child: CustomPaint(
        painter: HolePainter(
          gridSize: gameController.state.crossAxisCount,
        ),
        child: Container(),
      ),
    );
  }
}

class HolePainter extends CustomPainter {
  final gridSize;
  HolePainter({
    this.gridSize = 4,
  });
  @override
  void paint(Canvas canvas, Size size) {
    const blurRadius = 0.0;
    final paint = Paint()
      ..shader = const RadialGradient(
        colors: [
          Colors.black87,
          Colors.black26,
        ],
      ).createShader(
        Rect.fromCircle(
          center: const Offset(100, 100),
          radius: 300,
        ),
      )

      // The mask filter gives some fuziness to the cutout.
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, blurRadius);
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()
          ..addRRect(
            RRect.fromLTRBR(
              0,
              0,
              200,
              200,
              const Radius.circular(
                6,
              ),
            ),
          ),
        Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              Rect.fromCircle(
                center: const Offset(100, 100),
                radius: 200 / gridSize * ((gridSize - 2) / 2),
              ),
              const Radius.circular(4),
            ),
          )
          ..close(),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(HolePainter oldDelegate) {
    return gridSize != oldDelegate.gridSize;
  }
}
