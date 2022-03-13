import 'package:flutter/material.dart';
import 'package:rubrikrace/pages/controller/game_state.dart';

import '../../models/puzzle.dart';
import '../../models/tile.dart';

class GameController extends ChangeNotifier {
  GameState _state = GameState(
    crossAxisCount: 4,
    puzzle: Puzzle.create(4),
    solved: false,
    moves: 0,
    status: GameStatus.initial,
  );

  GameState get state => _state;
  Puzzle get puzzle => _state.puzzle;
  void onTileTapped(Tile tile) {
    final canMove = state.puzzle.canMoveTile(tile.position);
    if (canMove) {
      _state = state.copyWith(
        puzzle: state.puzzle.move(tile),
        moves: state.moves + 1,
      );
      notifyListeners();
    }
  }

  void shuffle() {
    _state = state.copyWith(
      puzzle: puzzle.shuffle(),
      moves: 0,
      status: GameStatus.initial,
    );
    notifyListeners();
  }

  void reset() {
    _state = state.copyWith(
      puzzle: Puzzle.create(state.crossAxisCount),
      moves: 0,
      status: GameStatus.initial,
    );
    notifyListeners();
  }

  void gridChange(int crossAxisCount) {
    _state = state.copyWith(
      crossAxisCount: crossAxisCount,
      puzzle: Puzzle.create(crossAxisCount),
      moves: 0,
      status: GameStatus.initial,
    );
    notifyListeners();
  }
}
