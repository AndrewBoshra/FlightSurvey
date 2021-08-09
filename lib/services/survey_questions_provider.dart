import 'package:flight_survey/models/question.dart';
import 'package:flight_survey/models/survey.dart';
import 'package:flutter/material.dart';

class SurveyQuestionsProvider extends ChangeNotifier {
  final Survey _survey;
  int _index = 0;
  SurveyQuestionsProvider(this._survey);

  void next() {
    if (_index >= _survey.questions.length) return;
    _index++;
    notifyListeners();
  }

  void back() {
    if (_index <= 0) return;
    _index--;
    notifyListeners();
  }

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

  int get index => _index;
}
