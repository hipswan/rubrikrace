import 'package:flutter/material.dart';

import '../../models/tile.dart';

class PuzzleTile extends StatelessWidget {
  final Tile tile;
  final double size;
  final VoidCallback onTap;
  const PuzzleTile({
    Key? key,
    required this.tile,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(
        milliseconds: 100,
      ),
      left: (tile.position.x - 1) * size,
      top: (tile.position.y - 1) * size,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size - 1,
          height: size - 1,
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: tile.color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              tile.value.toString(),
              style: TextStyle(
                fontSize: size * 0.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
