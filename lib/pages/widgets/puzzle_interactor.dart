import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rubrikrace/pages/controller/game_controller.dart';
import 'package:rubrikrace/pages/controller/game_state.dart';
import 'package:rubrikrace/pages/widgets/puzzle_tile.dart';

class PuzzleInteractor extends StatelessWidget {
  const PuzzleInteractor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(
          4,
        ),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, constrainst) {
          final controller = context.watch<GameController>();
          final state = controller.state;
          final tileSize = 200 / state.crossAxisCount;

          return AbsorbPointer(
            absorbing: state.status == GameStatus.playing,
            child: Stack(
              children: state.puzzle.tiles.map((e) {
                return PuzzleTile(
                  tile: e,
                  size: tileSize,
                  onTap: () => controller.onTileTapped(e),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
