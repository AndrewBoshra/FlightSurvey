class Question<T> {
  final String questionBody;
  final List<T> possibleChoices;
  Question({required this.possibleChoices, required this.questionBody});
}

class Answer<T> {
  final Question<T> question;
  T? _answer;
  Answer(this.question);

  bool isValid(T answer) {
    return question.possibleChoices.contains(answer);
  }

  bool choose(T answer) {
    if (isValid(answer)) {
      _answer = answer;
      return true;
    }
    return false;
  }

  T? get answer => _answer;
}
