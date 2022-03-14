import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rubrikrace/pages/controller/game_state.dart';

import '../../models/puzzle.dart';
import '../../models/tile.dart';

class GameController extends ChangeNotifier {
  // Use late keyword: Dart 2.12 comes with late keyword which helps you do the lazy initialization which means until the field bar is used it would remain uninitialized.

  GameState _state = GameState(
    crossAxisCount: 4,
    puzzle: Puzzle.create(4),
    solved: false,
    moves: 0,
    status: GameStatus.initial,
  );
  final ValueNotifier<int> time = ValueNotifier(0);
  final StreamController<void> _streamController = StreamController.broadcast();

  Stream<void> get onFinish => _streamController.stream;

  Timer? _timer;
  GameState get state => _state;
  Puzzle get puzzle => _state.puzzle;
  void onTileTapped(Tile tile) {
    final canMove = state.puzzle.canMoveTile(tile.position);
    if (canMove) {
      final newPuzzle = puzzle.move(tile);
      final solved = newPuzzle.isSolved();
      _state = state.copyWith(
        puzzle: newPuzzle,
        moves: state.moves + 1,
        status: solved ? GameStatus.finished : state.status,
      );
      notifyListeners();
      if (solved) {
        _timer?.cancel();
        _streamController.sink.add(null);
      }
      // _state = state.copyWith(
      //   puzzle: state.puzzle.move(tile),
      //   moves: state.moves + 1,
      // );
      // notifyListeners();
    }
  }

  void shuffle() {
    if (_timer != null) {
      time.value = 0;
      _timer!.cancel();
    }
    _state = state.copyWith(
      puzzle: puzzle.shuffle(),
      status: GameStatus.playing,
      moves: 0,
    );

    notifyListeners();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        time.value++;
      },
    );
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
    _timer?.cancel();
    time.value = 0;
    final newState = GameState(
      crossAxisCount: crossAxisCount,
      puzzle: Puzzle.create(crossAxisCount),
      solved: false,
      moves: 0,
      status: GameStatus.initial,
    );
    _state = newState;
    notifyListeners();
  }

  @override
  void dispose() {
    _streamController.close();
    _timer?.cancel();
    super.dispose();
  }
}
