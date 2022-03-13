import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rubrikrace/pages/controller/game_controller.dart';
import 'package:rubrikrace/pages/controller/game_state.dart';

class GameButtons extends StatelessWidget {
  const GameButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    final state = controller.state;
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(children: [
        TextButton.icon(
            onPressed: () {
              controller.shuffle();
            },
            icon: Icon(Icons.replay_rounded),
            label: Text(state.status == GameStatus.initial ? 'Start' : 'Stop')),
      ]),
    );
  }
}
