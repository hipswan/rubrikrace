import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rubrikrace/pages/game_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  var animationController;
  var animation;
  var gridSize = 4;
  var rotate_Y = 0.0;
  var gameView = LabeledGlobalKey<GameViewState>('game-view');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 700,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(animationController)
      ..addListener(() {
        // print(animation.value);
        setState(() {
          rotate_Y = animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // animationController.forward();
        }
      });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 109, 111, 113),
                Color.fromARGB(255, 95, 98, 98),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fromRect(
                rect: Rect.fromLTWH(
                  0,
                  0,
                  MediaQuery.of(context).size.width,
                  80,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          animationController.forward();
                        },
                        child: Text('Start'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          gameView.currentState!.doShuffle();
                        },
                        child: Text('Shuffle'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          gameView.currentState!.reset();
                        },
                        child: Text('Reset'),
                      ),
                    ),
                    Expanded(
                      child: DropdownButton<int>(
                        value: 4,
                        items: List.generate(3, (index) {
                          var val = index + 4;
                          return DropdownMenuItem<int>(
                            child: Text('$val x $val'),
                            value: val,
                          );
                        }),
                        onChanged: (value) {
                          gameView.currentState!.gridChange(value!);
                          setState(() {
                            gridSize = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: ScaleTransition(
                    scale: Tween<double>(
                      begin: 1.4,
                      end: 1.8,
                    ).animate(
                      CurvedAnimation(
                        parent: animationController,
                        curve: Curves.bounceOut,
                        reverseCurve: Curves.bounceIn,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          height: 200.0,
                          width: 200.0,
                          child: GameView(key: gameView),
                        ),
                        Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.002)
                            ..rotateX(rotate_Y),
                          alignment: FractionalOffset.center,
                          origin: const Offset(
                            0,
                            100,
                          ),
                          child: Stack(
                            children: [
                              Transform(
                                transform: Matrix4.identity()
                                  ..setEntry(2, 3, 0)
                                  ..rotateY(2 * pi),
                                child: Container(
                                  height: 200.0,
                                  width: 200.0,
                                  child: CustomPaint(
                                    painter: HolePainter(
                                      color: Colors.blue,
                                      gridSize: gridSize,
                                    ),
                                    child: Container(),
                                  ),
                                ),
                              ),
                              //  0 - pi to 1 - 0  -- > 1 - 6/pi * pi
                              Opacity(
                                opacity: 1 - (rotate_Y / pi),
                                child: Container(
                                  height: 200.0,
                                  width: 200.0,
                                  child: CustomPaint(
                                    painter: HolePainter(
                                      color: Colors.red,
                                      gridSize: gridSize,
                                    ),
                                    child: Container(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  child: ElevatedButton(
                    onPressed: () {
                      animationController.reverse();
                    },
                    child: Text('Done'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HolePainter extends CustomPainter {
  final gridSize;
  final Color color;
  HolePainter({
    this.color = Colors.black,
    this.gridSize = 4,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()
          ..addRRect(
            RRect.fromLTRBR(
              0,
              0,
              200,
              200,
              const Radius.circular(
                6,
              ),
            ),
          ),
        Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              Rect.fromCircle(
                center: const Offset(100, 100),
                radius: 200 / gridSize * ((gridSize - 2) / 2),
              ),
              const Radius.circular(4),
            ),
          )
          ..close(),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
