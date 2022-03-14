import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/time_parser.dart';
import '../controller/game_controller.dart';

class TimeAndMoves extends StatelessWidget {
  const TimeAndMoves({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = Provider.of<GameController>(context, listen: false).time;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ValueListenableBuilder<int>(
            valueListenable: time,
            builder: (_, time, icon) {
              return Center(
                child: Container(
                  width: 125,
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      icon!,
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        parseTime(time),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.watch_later_rounded,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Selector<GameController, int>(
            builder: (_, moves, __) {
              return Center(
                child: Container(
                  width: 125,
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Moves: $moves",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              );
            },
            selector: (_, controller) => controller.state.moves,
          ),
        ),
      ],
    );
  }
}
