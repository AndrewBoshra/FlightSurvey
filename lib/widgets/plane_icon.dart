import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlaneIcon extends StatelessWidget {
  const PlaneIcon({Key? key, this.size}) : super(key: key);

  final double? size;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi,
      child: SvgPicture.asset(
        'assets/svgs/plane.svg',
        width: size,
      ),
    );
  }
}
