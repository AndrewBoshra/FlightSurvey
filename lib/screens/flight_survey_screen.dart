import 'dart:math';
import 'dart:ui';

import 'package:flight_survey/constants/colors.dart';
import 'package:flight_survey/constants/dims.dart';
import 'package:flight_survey/widgets/dot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlightSurveyScreen extends StatelessWidget {
  const FlightSurveyScreen({Key? key}) : super(key: key);

  Widget _line() {
    return Positioned(
        left: kPlaneleft + kPlaneSize / 2 - kLineWidth / 2,
        top: kPlanetop + kPlaneSize / 2,
        width: kLineWidth,
        bottom: 0,
        child: ColoredBox(color: Colors.white.withOpacity(.3)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimary, kPrimaryVariant],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              print('back');
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: kPlanetop - kPlaneBlur,
              left: kPlaneleft - kPlaneBlur,
              child: Transform.rotate(
                angle: pi,
                child: SvgPicture.asset(
                  'assets/svgs/plane.svg',
                  width: kPlaneSize + 2 * kPlaneBlur,
                ),
              ),
            ),
            //Glow Filter
            Positioned(
              top: kPlanetop,
              left: kPlaneleft,
              child: ClipRect(
                child: BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: kPlaneBlur, sigmaY: kPlaneBlur),
                  child: SizedBox(
                    child: Transform.rotate(
                      angle: pi,
                      child: SvgPicture.asset(
                        'assets/svgs/plane.svg',
                        width: kPlaneSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _line(),
          ],
        ),
      ),
    );
  }
}
