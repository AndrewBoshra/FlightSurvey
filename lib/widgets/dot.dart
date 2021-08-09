import 'package:flutter/material.dart';

const double dotDimension = 13;

class Dot extends StatelessWidget {
  final Color color;
  const Dot({
    this.color = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: SizedBox(
        height: dotDimension,
        width: dotDimension,
      ),
    );
  }
}
