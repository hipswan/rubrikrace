import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rubrikrace/models/position.dart';
import 'package:rubrikrace/models/tile.dart';
import 'dart:math' as math;

class Puzzle extends Equatable {
  final List<Tile> tiles;
  final Position emptyTilePosition;

  const Puzzle._({required this.tiles, required this.emptyTilePosition});

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
    );
  }

  factory Puzzle.create(int crossAxisCount) {
    int value = 1;
    final tiles = <Tile>[];
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

    return Puzzle._(tiles: tiles, emptyTilePosition: emptyTilePosition);
  }

  static setColor(x, y, crossAxisCount) {
    if (y == crossAxisCount) {
      return Colors.red;
    } else {
      return Colors.accents.elementAt(x);
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

    return Puzzle._(
      tiles: copy,
      emptyTilePosition: emptyTilePosition,
    );
  }

  @override
  List<Object?> get props => [tiles, emptyTilePosition];
}
