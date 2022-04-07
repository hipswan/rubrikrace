// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:rubrikrace/pages/controller/game_controller.dart';
import 'package:rubrikrace/pages/controller/game_state.dart';
import 'package:rubrikrace/pages/widgets/puzzle_tile.dart';

class PuzzleInteractor extends StatelessWidget {
  const PuzzleInteractor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: const NeumorphicStyle(
        depth: -2,
        color: Color(0xffffe4c1),
        shadowDarkColor: Colors.black,
        shadowLightColor: Colors.black,
        shadowDarkColorEmboss: Colors.black,
        shadowLightColorEmboss: Colors.black,
        intensity: 0.5,
        oppositeShadowLightSource: false,
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, constrainst) {
          final controller = context.watch<GameController>();
          final state = controller.state;
          final tileSize = 200 / state.crossAxisCount;

          return AbsorbPointer(
            absorbing: state.status != GameStatus.playing,
            child: Stack(
              children: [
                ...state.puzzle.tiles.map((e) {
                  return PuzzleTile(
                    tile: e,
                    size: tileSize,
                    onTap: () => controller.onTileTapped(e),
                  );
                }).toList(),
                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: true,
                    child: CustomPaint(
                      painter: ResultCheckPainter(
                        gridSize: state.crossAxisCount,
                        resultColor:
                            controller.state.status == GameStatus.finished
                                ? Colors.greenAccent
                                : Colors.redAccent.withOpacity(
                                    0.8,
                                  ),
                      ),
                      child: Container(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ResultCheckPainter extends CustomPainter {
  var gridSize;
  var resultColor;
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
