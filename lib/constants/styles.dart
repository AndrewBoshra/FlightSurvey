import 'package:flutter/material.dart';
import 'package:flight_survey/constants/colors.dart';

ThemeData kThemeData = ThemeData(
  colorScheme: ColorScheme.light().copyWith(
    primary: kPrimary,
    primaryVariant: kPrimaryVariant,
    onPrimary: kOnPrimary,
    secondary: kSecondary,
  ),
  textTheme: ThemeData.dark().textTheme.copyWith(
        headline2: ThemeData.dark().textTheme.headline2!.copyWith(
              color: kSecondary,
              fontWeight: FontWeight.w900,
              fontSize: 65,
            ),
        headline4: ThemeData.dark().textTheme.headline4!.copyWith(
              fontFamily: 'Georama',
              color: kOnPrimary,
              fontWeight: FontWeight.w400,
              fontSize: 30,
            ),
        headline6: ThemeData.dark().textTheme.headline6!.copyWith(
              fontFamily: 'Georama',
              fontWeight: FontWeight.w400,
            ),
      ),
);
