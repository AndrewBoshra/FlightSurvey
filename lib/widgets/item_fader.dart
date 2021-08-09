import 'package:flutter/material.dart';

class ItemFader extends StatefulWidget {
  final Widget child;
  const ItemFader({Key? key, required this.child}) : super(key: key);
  @override
  ItemFaderState createState() => ItemFaderState();
}

class ItemFaderState extends State<ItemFader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late CurvedAnimation _animation;
  var position = VerticalDirection.down;
  static const maxVerticalOffset = 90;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animation.addListener(() {});
  }

  void fadeIn() {
    position = VerticalDirection.down;
    _animationController.value = 0;
    _animationController.forward();
  }

  void fadeOut() {
    position = VerticalDirection.up;
    _animationController.value = 0;
    _animationController.forward();
  }

  double _getOpacity() => position == VerticalDirection.down
      ? _animation.value
      : 1 - _animation.value;

  double _getOffsetY() => position == VerticalDirection.down
      ? maxVerticalOffset * (1 - _animation.value)
      : maxVerticalOffset * (-_animation.value);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _getOffsetY()),
          child: Opacity(
            opacity: _getOpacity(),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
