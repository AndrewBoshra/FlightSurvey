class Survey {
  final String surveyBody;
  final List<String> choices;
  Survey({required this.choices, required this.surveyBody});
}

Survey testSurvey = Survey(
    choices: ['Bussines', 'Personal', 'Others'],
    surveyBody:
        'Do you typically fly for bussines , personal reasons, or some other reason?');
