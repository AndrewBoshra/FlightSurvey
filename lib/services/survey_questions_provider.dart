import 'package:flight_survey/models/question.dart';
import 'package:flight_survey/models/survey.dart';
import 'package:flutter/material.dart';

class SurveyQuestionsProvider extends ChangeNotifier {
  final Survey _survey;
  int _index = 0;
  SurveyQuestionsProvider(this._survey);

  void next() {
    if (!canGoForward()) return;
    _index++;
    notifyListeners();
  }

  void back() {
    if (!canGoBack()) return;
    _index--;
    notifyListeners();
  }

  bool canGoBack() => (_index > 0);
  bool canGoForward() => (_index < _survey.questions.length - 1);

  Question getCurrentQuestion() {
    return _survey.questions[_index];
  }

  bool answerCurrentQuestion(answer) {
    if (_survey.answerQuestion(_index, answer)) {
      next();
      return true;
    }
    return false;
  }

  int get index => _index + 1;
}
