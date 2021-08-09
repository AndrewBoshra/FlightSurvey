import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final VoidCallback onPressed;
  final double elevation;
  const RoundedButton(
      {Key? key,
      Color? backgroundColor,
      required this.child,
      double? elevation,
      required this.onPressed})
      : backgroundColor = backgroundColor ?? Colors.transparent,
        elevation = elevation ?? 0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: child,
      fillColor: backgroundColor,
      shape: CircleBorder(),
      padding: EdgeInsets.all(8),
      elevation: elevation,
      hoverElevation: elevation,
    );
  }
}
