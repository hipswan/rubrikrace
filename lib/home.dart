import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rubrikrace/pages/controller/game_controller.dart';
import 'package:rubrikrace/pages/game_view.dart';
import 'package:image/image.dart' as IMG;

import 'pages/widgets/time_and_moves.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // Future<Null> init() async {
  //   final ByteData data = await rootBundle.load('images/lake.jpg');
  //   image = await loadImage(new Uint8List.view(data.buffer));
  // }

  // void loadRubrikRace(String img) async {
  //   final ByteData data = await rootBundle.load(img);
  //   rubrikrace =
  //       (await decodeImageFromList(Uint8List.view(data.buffer))) as IMG.Image?;
  //   rubrikrace = IMG.copyResize(rubrikrace!, width: 50, height: 50);
  // }

  // void loadRubrikCube(String img) async {
  //   final ByteData data = await rootBundle.load(img);

  //   rubrikcube = await decodeImageFromList(Uint8List.view(data.buffer));
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GameView(),
      ),
    );
  }
}
