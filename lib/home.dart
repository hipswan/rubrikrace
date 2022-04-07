import 'package:flutter/material.dart';
import 'package:rubrikrace/pages/game_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: GameView(),
      ),
    );
  }
}
