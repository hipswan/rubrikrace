import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rubrikrace/pages/controller/game_controller.dart';
import 'package:rubrikrace/pages/widgets/done_button.dart';
import 'package:rubrikrace/pages/widgets/game_buttons.dart';
import 'package:rubrikrace/pages/widgets/puzzle_interactor.dart';
import 'package:rubrikrace/pages/widgets/template_view.dart';
import 'package:rubrikrace/utils/hole_widget.dart';
import 'package:rubrikrace/utils/time_parser.dart';

import '../utils/circle_button.dart';
import 'widgets/time_and_moves.dart';

class GameView extends StatefulWidget {
  GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() => GameViewState();
}

class GameViewState extends State<GameView>
    with SingleTickerProviderStateMixin {
  // void doShuffle() {
  //   widget.controller.shuffle();
  // }

  // void reset() {
  //   widget.controller..reset();
  // }

  // void gridChange(int value) {
  //   widget.controller.gridChange(value);
  // }

  var animationController;
  var animation;
  var gridSize = 4;
  var rotate_Y = 0.0;
  var gameView = LabeledGlobalKey<GameViewState>('game-view');
  var templateView = LabeledGlobalKey<GameViewState>('template-view');

  var rubrikcube;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadRubrikRace('assets/rubrikrace.png');

    // loadRubrikCube('assets/rubrikcube.png');
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
    // animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameController>(
      create: (_) {
        final controller = GameController();
        controller.onFinish.listen(
          (_) {
            Timer(
              const Duration(
                milliseconds: 200,
              ),
              () {
                _showWinnerDialog(context, controller);
              },
            );
          },
        );
        return controller;
      },
      child: Container(
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
          fit: StackFit.expand,
          children: [
            Positioned(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                child: Column(
                  children: [
                    GameButton(
                      onPlay: () {
                        animationController.forward();
                      },
                      onGridChange: () {
                        animationController.reverse();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TimeAndMoves(),
                  ],
                ),
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
                      const SizedBox(
                        height: 200.0,
                        width: 200.0,
                        child: Padding(
                          padding: EdgeInsets.all(
                            0,
                          ),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: PuzzleInteractor(),
                          ),
                        ),
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
                          children: const [
                            //  0 - pi to 1 - 0  -- > 1 - 6/pi * pi
                            HoleWidget(),
                            Positioned(
                              left: 30,
                              top: 4,
                              child: Image(
                                width: 150,
                                image: AssetImage(
                                  'assets/rubrikcube.png',
                                ),
                              ),
                            ),
                            Positioned(
                              left: 100 - 35 / 2,
                              bottom: 5,
                              child: Center(
                                child: Image(
                                  width: 35,
                                  height: 35,
                                  image: AssetImage(
                                    'assets/rubrikrace.png',
                                  ),
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
              child: DoneButton(
                onDone: () {
                  animationController.reverse();
                },
              ),
            ),
            const Positioned(
              bottom: 85,
              right: 0,
              width: 120,
              height: 120,
              child: TemplateView(),
            ),
          ],
        ),
      ),
    );
  }

  void _showWinnerDialog(
    BuildContext context,
    GameController controller,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("GREAT JOB"),
            Text("moves: ${controller.state.moves}"),
            Text("time: ${parseTime(controller.time.value)}"),
            const SizedBox(height: 20),
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
