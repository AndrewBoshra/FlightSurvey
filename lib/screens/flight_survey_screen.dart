import 'dart:ui';

import 'package:flight_survey/animation/survey_page_swap.dart';
import 'package:flight_survey/constants/animation.dart';
import 'package:flight_survey/constants/colors.dart';
import 'package:flight_survey/constants/dims.dart';
import 'package:flight_survey/services/survey_questions_provider.dart';
import 'package:flight_survey/widgets/plane_icon.dart';
import 'package:flight_survey/widgets/survey_page.dart';
import 'package:flight_survey/widgets/up_down_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlightSurveyScreen extends StatelessWidget {
  const FlightSurveyScreen({Key? key}) : super(key: key);
  static const String route = 'flight_survey';

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
        body: Consumer<SurveyQuestionsProvider>(
          builder: (context, survey, _) =>
              Consumer<SwapSurveyPageAnimationProvider>(
            builder: (context, value, child) => Stack(
              children: [
                GlowingPlane(
                  key: value.planeKey,
                ),
                Positioned(
                  bottom: 40,
                  left: -5,
                  child: UpDownButtons(
                    onDownPressed: !survey.canGoBack()
                        ? null
                        : () async {
                            await value.animateOut();
                            survey.back();
                          },
                    onUpPressed: !survey.canGoForward()
                        ? null
                        : () async {
                            await value.animateOut();
                            survey.next();
                          },
                  ),
                ),
                _line(),
                Positioned(
                  left: kPlaneleft + kPlaneSize / 2 - kDotDimension / 2,
                  right: kPlaneleft,
                  bottom: kPlanetop + kPlaneSize,
                  top: kPlanetop,
                  child: SurveyPage(
                    index: survey.index,
                    question: survey.getCurrentQuestion(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GlowingPlane extends StatefulWidget {
  const GlowingPlane({Key? key}) : super(key: key);

  @override
  GlowingPlaneState createState() => GlowingPlaneState();
}

class GlowingPlaneState extends State<GlowingPlane>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late CurvedAnimation _animation;

  Future glow() async {
    await _animationController.forward();
    await Future.delayed(kPlaneGlowDuration);
    await _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: kFadeDelay,
    );
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeOutExpo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: kPlanetop - kPlaneBlur,
          left: kPlaneleft - kPlaneBlur,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) =>
                Opacity(opacity: _animation.value, child: child),
            child: PlaneIcon(
              size: kPlaneSize + 2 * kPlaneBlur,
            ),
          ),
        ),
        //Glow Filter
        Positioned(
          top: kPlanetop,
          left: kPlaneleft,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: kPlaneBlur, sigmaY: kPlaneBlur),
            child: SizedBox(
              child: Hero(
                tag: 'plane logo',
                child: PlaneIcon(size: kPlaneSize),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
