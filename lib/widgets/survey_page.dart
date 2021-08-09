import 'package:flight_survey/constants/dims.dart';
import 'package:flight_survey/models/question.dart';
import 'package:flight_survey/services/survey_questions_provider.dart';
import 'package:flight_survey/widgets/dot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyPage extends StatefulWidget {
  final Question question;
  final int index;
  const SurveyPage({Key? key, required this.index, required this.question})
      : super(key: key);
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var choices = Provider.of<SurveyQuestionsProvider>(context)
        .getCurrentQuestion()
        .possibleChoices;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.index > 9
              ? widget.index.toString()
              : '0' + widget.index.toString(),
          style: textTheme.headline2,
        ),
        Text(
          widget.question.questionBody,
          style: textTheme.headline6,
        ),
        Spacer(),
        ...choices.map(
          (choice) => Column(
            children: [
              SizedBox(
                height: kVerticalSpacingUnit,
              ),
              Text(
                choice.toString(),
                style: textTheme.headline4,
              ),
            ],
          ),
        )
      ],
    );
  }
}
