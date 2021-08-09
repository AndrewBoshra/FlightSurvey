import 'package:flight_survey/constants/dims.dart';
import 'package:flutter/material.dart';

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
        height: kDotDimension,
        width: kDotDimension,
      ),
    );
  }
}
