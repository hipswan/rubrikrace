import 'package:equatable/equatable.dart';
import 'package:rubrikrace/models/position.dart';

class Tile extends Equatable {
  final int value;
  final Position position;
  final Position correctPosition;
  final bool? isCorrect;
  final color;

  const Tile(
      {required this.value,
      required this.position,
      required this.correctPosition,
      this.isCorrect,
      this.color});

  Tile move(Position newPosition) {
    return Tile(
        value: value,
        position: newPosition,
        correctPosition: correctPosition,
        isCorrect: isCorrect,
        color: color);
  }

  List<Object?> get props => [
        position,
        correctPosition,
        isCorrect,
        value,
        color,
      ];
}
