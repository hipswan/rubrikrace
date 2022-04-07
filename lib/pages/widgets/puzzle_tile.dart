import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
        child: SizedBox(
          width: size - 1,
          height: size - 1,
          child: Neumorphic(
            margin: const EdgeInsets.all(1),
            style: NeumorphicStyle(
              border: const NeumorphicBorder(
                color: Colors.black,
                width: 0,
              ),
              depth: 3,
              color: Colors.black,
              intensity: 0.7,
              shadowLightColor: Colors.black26,
              shadowDarkColor: Colors.black.withOpacity(
                0.75,
              ),
              shadowDarkColorEmboss: Colors.grey,
              shadowLightColorEmboss: Colors.grey,
              shape: NeumorphicShape.convex,
            ),
            child: Center(
              child: SizedBox(
                width: size - 12,
                height: size - 12,
                child: Neumorphic(
                  style: NeumorphicStyle(
                    color: tile.color,
                    depth: 2,
                    shape: NeumorphicShape.concave,
                  ),
                  child: Container(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
