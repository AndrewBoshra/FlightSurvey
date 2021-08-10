import 'package:flight_survey/constants/colors.dart';
import 'package:flight_survey/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class UpDownButtons extends StatelessWidget {
  const UpDownButtons(
      {Key? key, required this.onDownPressed, required this.onUpPressed})
      : super(key: key);
  final VoidCallback? onDownPressed;
  final VoidCallback? onUpPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedButton(
          onPressed: onUpPressed,
          child: Icon(
            Icons.arrow_upward,
            color: kOnPrimary,
          ),
        ),
        RoundedButton(
          child: Icon(
            Icons.arrow_downward,
            color: kPrimaryVariant,
          ),
          onPressed: onDownPressed,
          backgroundColor: kOnPrimary,
        )
      ],
    );
  }
}
