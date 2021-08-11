import 'package:flight_survey/constants/colors.dart';
import 'package:flight_survey/constants/dims.dart';
import 'package:flight_survey/screens/flight_survey_screen.dart';
import 'package:flight_survey/widgets/plane_icon.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  static const String route = 'loading';

  @override
  Widget build(BuildContext context) {
    //to simulate loading the data....
    Future.delayed(Duration(seconds: 1))
        .then((_) => Navigator.pushNamed(context, FlightSurveyScreen.route));

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimary, kPrimaryVariant],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'plane logo',
                child: PlaneIcon(
                  size: kPlaneSize * 3,
                ),
              ),
              SizedBox(
                height: kVerticalSpacingUnit,
              ),
              Text(
                'We Care..',
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
