import 'package:flight_survey/constants/styles.dart';
import 'package:flight_survey/models/survey.dart';
import 'package:flight_survey/screens/flight_survey_screen.dart';
import 'package:flight_survey/screens/loading_screen.dart';
import 'package:flight_survey/services/survey_questions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'animation/survey_page_swap.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SurveyQuestionsProvider>(
          create: (context) => SurveyQuestionsProvider(testSurvey),
        ),
        ChangeNotifierProvider<SwapSurveyPageAnimationProvider>(
          create: (context) => SwapSurveyPageAnimationProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        title: 'Flight Survey',
        theme: kThemeData,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case LoadingScreen.route:
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    LoadingScreen(),
              );
            case FlightSurveyScreen.route:
              return PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                pageBuilder: (context, _, __) => FlightSurveyScreen(),
              );
          }
        },
        initialRoute: LoadingScreen.route,
      ),
    );
  }
}
