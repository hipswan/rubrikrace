import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rubrikrace/models/position.dart';
import 'package:rubrikrace/models/tile.dart';
import 'dart:math' as math;

class Puzzle extends Equatable {
  final List<Tile> templateTiles;
  final List<Tile> tiles;
  final Position emptyTilePosition;
  static List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.white,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.grey,
    Colors.teal,
    Colors.indigo,
    Colors.lime,
    Colors.cyan,
    Colors.lightGreen,
    Colors.limeAccent,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.indigoAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.limeAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.purpleAccent,
    Colors.redAccent,
    Colors.tealAccent,
    Colors.yellowAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.grey,
    Colors.black,
  ];
  const Puzzle._(
      {required this.tiles,
      required this.emptyTilePosition,
      required this.templateTiles});

  bool canMoveTile(Position tilePosition) {
    return tilePosition.x == emptyTilePosition.x ||
        tilePosition.y == emptyTilePosition.y;
  }

  Puzzle move(Tile tile) {
    //left or right
    final copy = [...tiles];
    if (tile.position.y == emptyTilePosition.y) {
      final rows =
          tiles.where((element) => element.position.y == emptyTilePosition.y);
      if (tile.position.x < emptyTilePosition.x) {
        //right
        for (final e in rows) {
          if (e.position.x < tile.position.x ||
              e.position.x > emptyTilePosition.x) {
            continue;
          }
          copy[e.value - 1] = e.move(
            Position(
              x: e.position.x + 1,
              y: e.position.y,
            ),
          );
        }
      } else {
        //left
        for (final e in rows) {
          if (e.position.x > tile.position.x ||
              e.position.x < emptyTilePosition.x) {
            continue;
          }
          copy[e.value - 1] = e.move(
            Position(
              x: e.position.x - 1,
              y: e.position.y,
            ),
          );
        }
      }
    } else {
      //top or bottom
      final columns =
          tiles.where((element) => element.position.x == emptyTilePosition.x);
      //bottom
      if (tile.position.y < emptyTilePosition.y) {
        //bottom
        for (final e in columns) {
          if (e.position.y < tile.position.y ||
              e.position.y > emptyTilePosition.y) {
            continue;
          }
          copy[e.value - 1] = e.move(
            Position(
              x: e.position.x,
              y: e.position.y + 1,
            ),
          );
        }
      } else {
        //top
        for (final e in columns) {
          if (e.position.y > tile.position.y ||
              e.position.y < emptyTilePosition.y) {
            continue;
          }
          copy[e.value - 1] = e.move(
            Position(
              x: e.position.x,
              y: e.position.y - 1,
            ),
          );
        }
      }
    }
    return Puzzle._(
      tiles: copy,
      emptyTilePosition: tile.position,
      templateTiles: templateTiles,
    );
  }

  factory Puzzle.create(int crossAxisCount) {
    int value = 1;
    final tiles = <Tile>[];
    var templateTiles = <Tile>[];
    final emptyTilePosition = Position(
      x: crossAxisCount,
      y: crossAxisCount,
    );
    for (int y = 1; y <= crossAxisCount; y++) {
      for (int x = 1; x <= crossAxisCount; x++) {
        if (x == crossAxisCount && y == crossAxisCount) {
          continue;
        }
        final Position position = Position(x: x, y: y);
        final Tile tile = Tile(
            value: value,
            position: position,
            correctPosition: position,
            color: setColor(x, y, crossAxisCount));
        tiles.add(tile);

        value++;
      }
    }
    var templateSize = (crossAxisCount - 2);

    templateTiles = [...tiles.sublist(0, templateSize * templateSize).toList()];

    templateTiles.add(tiles.last);
    templateTiles.shuffle();
    var row = 1;

    for (int i = 1; i <= templateSize * templateSize; i++) {
      templateTiles[i - 1] = Tile.copy(
        tile: templateTiles[i - 1],
        position: Position(
          x: row,
          y: i % templateSize == 0 ? templateSize : i % templateSize,
        ),
      );

      if (i % templateSize == 0) {
        row++;
      }
    }
    templateTiles.removeLast();
    return Puzzle._(
        tiles: tiles,
        emptyTilePosition: emptyTilePosition,
        templateTiles: templateTiles);
  }

  static setColor(x, y, crossAxisCount) {
    if (y == crossAxisCount) {
      return Colors.red;
    } else {
      return colors[x];
    }
  }

  Puzzle shuffle() {
    // tiles.shuffle();
    final values = List.generate(tiles.length, (index) => index + 1)..add(0);

    values.shuffle();
    int y = 1;
    int x = 1;
    final copy = [...tiles];
    late Position emptyTilePosition;
    final int crossAxisCount = math.sqrt(values.length).toInt();
    for (int i = 0; i < values.length; i++) {
      final value = values[i];
      final Position position = Position(x: x, y: y);
      if (value == 0) {
        emptyTilePosition = position;
      } else {
        copy[value - 1] = copy[value - 1].move(
          position,
        );
      }
      if ((i + 1) % crossAxisCount == 0) {
        y++;
        x = 1;
      } else {
        x++;
      }
    }
    templateTiles.shuffle();
    return Puzzle._(
      tiles: copy,
      emptyTilePosition: emptyTilePosition,
      templateTiles: templateTiles,
    );
  }

  rotatedRight(list, int places) {
    final times = places % list.length;
    if (times == 0) {
      return list;
    } else {
      final cutOff = list.length - times;
      return list.sublist(cutOff)..addAll(list.sublist(0, cutOff));
    }
  }

  rotatedLeft(list, int places) {
    final times = places % list.length;
    if (times == 0) {
      return this;
    } else {
      return list.sublist(times)..addAll(list.sublist(0, times));
    }
  }

  bool _listComparison(List<Tile> list1, List<Tile> list2) {
    if (list1.length != list2.length) {
      return false;
    }
    for (int i = 0; i < list1.length; i++) {
      if (list1[i].color != list2[i].color) {
        return false;
      }
    }
    return true;
  }

  bool testIt(templateColors, currentColor) {
    bool isSolved = false;
    for (int i = 1; i <= 3; i++) {
      isSolved = isSolved ||
          _listComparison(rotatedRight(templateColors, i), currentColor);
      if (isSolved) {
        return true;
      }
      isSolved = isSolved ||
          _listComparison(rotatedLeft(templateColors, i), currentColor);
      if (isSolved) {
        return true;
      }
    }
    return isSolved;
  }

  bool isSolved() {
    final crossAxisCount = math.sqrt(tiles.length + 1).toInt();
    final List<Tile> templateColors = [];
    final List<Tile> currentColors = [];
    for (int x = 2; x <= crossAxisCount - 1; x++) {
      for (int y = 2; y <= crossAxisCount - 1; y++) {
        if (emptyTilePosition.x == x && emptyTilePosition.y == y) {
          continue;
        }

        final tile = tiles.firstWhere(
            (element) => element.position.x == x && element.position.y == y);
        currentColors.add(tile);
      }
    }
    for (int x = 1; x <= crossAxisCount - 2; x++) {
      for (int y = 1; y <= crossAxisCount - 2; y++) {
        final tile = templateTiles.firstWhere(
            (element) => element.position.x == x && element.position.y == y);
        templateColors.add(tile);
      }
    }

    if (_listComparison(templateColors, currentColors)) {
      return true;
    } else if (testIt(templateColors, currentColors)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  List<Object?> get props => [tiles, emptyTilePosition, templateTiles];
}
