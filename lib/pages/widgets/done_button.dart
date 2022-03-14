import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/game_controller.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({
    Key? key,
    required this.onDone,
  }) : super(key: key);
  final VoidCallback onDone;
  @override
  Widget build(BuildContext context) {
    var gameController = Provider.of<GameController>(context);

    return SizedBox(
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          onDone();
          gameController.gridChange(gameController.state.crossAxisCount);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.black54,
          ),
        ),
        child: Text('Done'),
      ),
    );
  }
}
