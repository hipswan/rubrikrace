import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rubrikrace/pages/controller/game_controller.dart';
import 'package:rubrikrace/pages/widgets/game_buttons.dart';
import 'package:rubrikrace/pages/widgets/puzzle_interactor.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);
  static var controller = GameController();

  @override
  State<GameView> createState() => GameViewState();
}

class GameViewState extends State<GameView> {
  void doShuffle() {
    GameView.controller.shuffle();
  }

  void reset() {
    GameView.controller.reset();
  }

  void gridChange(int value) {
    GameView.controller.gridChange(value);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameView.controller,
      child: const Padding(
        padding: EdgeInsets.all(
          0,
        ),
        child: AspectRatio(
          aspectRatio: 1,
          child: PuzzleInteractor(),
        ),
      ),
    );
  }
}
