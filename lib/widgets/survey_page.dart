import 'package:flight_survey/animation/survey_page_swap.dart';
import 'package:flight_survey/constants/animation.dart';
import 'package:flight_survey/constants/dims.dart';
import 'package:flight_survey/models/question.dart';
import 'package:flight_survey/services/survey_questions_provider.dart';
import 'package:flight_survey/widgets/dot.dart';
import 'package:flight_survey/widgets/item_fader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyPage extends StatelessWidget {
  final Question question;
  final int index;
  const SurveyPage({required this.index, required this.question});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var choices = Provider.of<SurveyQuestionsProvider>(context)
        .getCurrentQuestion()
        .possibleChoices;
    var pageAnimation = Provider.of<SwapSurveyPageAnimationProvider>(context);
    pageAnimation.reset();

    var current = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: kPlaneSize / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemFader(
                key: pageAnimation.addHeader(),
                child: Text(
                  index > 9 ? index.toString() : '0' + index.toString(),
                  style: textTheme.headline2,
                ),
              ),
              ItemFader(
                key: pageAnimation.addHeader(),
                child: Text(
                  question.questionBody,
                  style: textTheme.headline6,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        ...choices.map((choice) => ItemFader(
            key: pageAnimation.addChoice(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: kVerticalSpacingUnit,
                ),
                OptionItem(option: choice.toString()),
              ],
            )))
      ],
    );
    pageAnimation.animateIn();
    return current;
  }
}

class OptionItem extends StatefulWidget {
  final String option;
  const OptionItem({Key? key, required this.option}) : super(key: key);

  @override
  _OptionItemState createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem>
    with SingleTickerProviderStateMixin {
  bool isDotVisible = true;

  void nextpage(SurveyQuestionsProvider surveyQuestionsProvider,
      SwapSurveyPageAnimationProvider swapSurveyPageAnimationProvider) async {
    if (surveyQuestionsProvider.canGoForward()) {
      await swapSurveyPageAnimationProvider.animateOut();
      surveyQuestionsProvider.next();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isDotVisible
            ? Dot()
            : Dot(
                color: Colors.transparent,
              ),
        SizedBox(
          width: kHorizontalSpacingUnit,
        ),
        Flexible(
          child: TextButton(
            onPressed: () async {
              var renderObj = context.findRenderObject() as RenderBox;
              var offset = renderObj.localToGlobal(Offset.zero);

              AnimationController animationController = AnimationController(
                vsync: this,
                duration: kDotTranslateDuration,
              );

              var animation = CurvedAnimation(
                  parent: animationController, curve: Curves.easeIn);

              var overlayedWidget = AnimatedBuilder(
                animation: animation,
                builder: (_, child) => Positioned(
                  child: child ?? Dot(),
                  top: (offset.dy +
                              renderObj.size.height / 2 -
                              kDotDimension / 2) *
                          (1 - animationController.value) +
                      kPlanetop +
                      kPlaneSize,
                  left: offset.dx,
                ),
                child: Dot(),
              );

              OverlayEntry entry = OverlayEntry(
                builder: (context) => overlayedWidget,
              );

              Overlay.of(context)?.insert(entry);
              setState(() {
                isDotVisible = false;
              });

              var animationProvider =
                  Provider.of<SwapSurveyPageAnimationProvider>(context,
                      listen: false);
              var surveyProvider =
                  Provider.of<SurveyQuestionsProvider>(context, listen: false);
              animationProvider.glowPlane();
              nextpage(surveyProvider, animationProvider);

              await animationController.forward();
              entry.remove();
              animationController.dispose();
            },
            child: Text(
              widget.option.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
      ],
    );
  }
}
