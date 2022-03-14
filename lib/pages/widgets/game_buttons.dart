import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rubrikrace/pages/controller/game_controller.dart';
import 'package:rubrikrace/pages/controller/game_state.dart';

import '../../utils/circle_button.dart';

class GameButton extends StatelessWidget {
  const GameButton({Key? key, required this.onPlay, this.onGridChange})
      : super(key: key);
  final onPlay;
  final onGridChange;
  @override
  Widget build(BuildContext context) {
    final gameController = Provider.of<GameController>(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CircleButton(
                icon: const Icon(
                  Icons.play_arrow_rounded,
                ),
                onPressed: () {
                  onPlay();
                  gameController.shuffle();
                },
              ),
            ),
            Expanded(
              child: CircleButton(
                icon: Icon(Icons.shuffle_rounded),
                onPressed: () {
                  gameController.shuffle();
                },
              ),
            ),
            Expanded(
              child: CircleButton(
                icon: const Icon(
                  Icons.replay,
                ),
                onPressed: () {
                  gameController.shuffle();
                },
              ),
            ),
            Expanded(
              child: DropdownButton<int>(
                dropdownColor: Colors.black54,
                value: gameController.state.crossAxisCount,
                items: [4, 5, 6]
                    .map((index) => DropdownMenuItem<int>(
                          child: Text(
                            '$index x $index',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          value: index,
                        ))
                    .toList(),
                onChanged: (value) {
                  gameController.gridChange(value!);
                  onGridChange();
                },
              ),
            )
          ],
        ),
        // GameView(
        //   key: templateView,
        //   controller: GameController().,
        // )
      ],
    );
  }
}
