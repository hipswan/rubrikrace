import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rubrikrace/pages/widgets/puzzle_tile.dart';
import 'dart:math';
import '../../models/tile.dart';
import '../controller/game_controller.dart';

class TemplateView extends StatelessWidget {
  const TemplateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameController = Provider.of<GameController>(context);
    final tiles = gameController.puzzle.templateTiles;
    return tiles.isEmpty
        ? Container()
        : Stack(
            children: tiles.map((e) {
              return PuzzleTile(
                tile: e,
                size: 120 / sqrt(tiles.length),
                onTap: () => {},
              );
            }).toList(),
          );
  }
}
