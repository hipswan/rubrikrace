import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rubrikrace/models/position.dart';

class Tile extends Equatable {
  final int value;
  Position position;
  final Position correctPosition;
  final bool? isCorrect;
  final color;

  Tile(
      {required this.value,
      required this.position,
      required this.correctPosition,
      this.isCorrect,
      this.color});

  factory Tile.copy({required Tile tile, required Position position}) {
    return Tile(
      value: tile.value,
      position: position,
      correctPosition: tile.correctPosition,
      isCorrect: tile.isCorrect,
      color: tile.color,
    );
  }

  Colors get getColor => this.color;
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
