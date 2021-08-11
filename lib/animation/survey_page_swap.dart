import 'package:flight_survey/constants/animation.dart';
import 'package:flight_survey/screens/flight_survey_screen.dart';
import 'package:flight_survey/widgets/item_fader.dart';
import 'package:flutter/material.dart';

class SwapSurveyPageAnimationProvider extends ChangeNotifier {
  var _choices = <GlobalKey<ItemFaderState>>[];
  var _headers = <GlobalKey<ItemFaderState>>[];
  var _plane = GlobalKey<GlowingPlaneState>();

  void reset() {
    _choices = [];
    _headers = [];
    _plane = GlobalKey<GlowingPlaneState>();
  }

  GlobalKey<ItemFaderState> addChoice() {
    var key = GlobalKey<ItemFaderState>();
    _choices.add(key);
    return key;
  }

  GlobalKey<ItemFaderState> addHeader() {
    var key = GlobalKey<ItemFaderState>();
    _headers.add(key);
    return key;
  }

  get planeKey => _plane;

  Future _animateListIn(List<GlobalKey<ItemFaderState>> list) async {
    var futures = <Future>[];
    for (var item in list) {
      await Future.delayed(kOffsetDelay);
      futures.add(item.currentState!.fadeIn());
    }
    return await Future.wait(futures);
  }

  Future _animateListOut(List<GlobalKey<ItemFaderState>> list) async {
    var futures = <Future>[];
    for (var item in list) {
      await Future.delayed(kOffsetDelay);
      futures.add(item.currentState!.fadeOut());
    }
    return await Future.wait(futures);
  }

  Future animateIn() async {
    var animations = <Future>[];
    animations.add(_animateListIn(_headers));
    animations.add(_animateListIn(_choices));
    await Future.wait(animations);
  }

  Future animateOut() async {
    var animations = <Future>[];
    animations.add(_animateListOut(_headers));
    animations.add(_animateListOut(_choices));
    await Future.wait(animations);
  }

  Future glowPlane() async => await _plane.currentState?.glow();
}
