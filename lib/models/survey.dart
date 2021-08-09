import 'package:flight_survey/models/question.dart';

class Survey {
  final List<Question> questions;
  List<Answer> answers = <Answer>[];

  Survey(this.questions);

  bool answerQuestion(int index, answer) {
    if (index < 0 || index >= questions.length) return false;
    if (answer.runtimeType != questions[index].possibleChoices[0].runtimeType)
      return false;

    Answer ans = Answer(questions[index]);
    if (ans.choose(answer)) {
      answers.add(ans);
      return true;
    }
    return false;
  }
}

//this survey is only for testing

Survey testSurvey = Survey([
  Question<String>(
    questionBody:
        'Do you typically fly for bussines ,personal reasons, or some other reason ?',
    possibleChoices: ['Business', 'Personal', 'Others'],
  ),
  Question<String>(
    questionBody: 'How many hours is your average flight ?',
    possibleChoices: [
      'Less than two hours.',
      'More than two ,but less than five.',
      'Others'
    ],
  ),
  Question<int>(
    questionBody: 'How many times do you typically fly each year ?',
    possibleChoices: [1, 2, 3, 4, 5],
  ),
]);
