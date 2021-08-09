import 'package:flight_survey/constants/styles.dart';
import 'package:flight_survey/models/survey.dart';
import 'package:flight_survey/screens/flight_survey_screen.dart';
import 'package:flight_survey/services/survey_questions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return ChangeNotifierProvider<SurveyQuestionsProvider>(
      create: (context) => SurveyQuestionsProvider(testSurvey),
      child: MaterialApp(
        title: 'Flight Survey',
        theme: kThemeData,
        debugShowCheckedModeBanner: false,
        home: FlightSurveyScreen(),
      ),
    );
  }
}
