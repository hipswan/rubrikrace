import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);
  final VoidCallback onPressed;
  final icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          CircleBorder(),
        ),
        backgroundColor: MaterialStateProperty.all(
          Colors.black54,
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(
            10,
          ),
        ),
      ),
      onPressed: onPressed,
      child: icon,
    );
  }
}
