part of 'assessment_questions_bloc.dart';

@immutable
sealed class AssessmentQuestionsEvent {}

class SaveQuestion1Event extends AssessmentQuestionsEvent {
  final String question1;

  SaveQuestion1Event({required this.question1});
}

class SaveQuestion2Event extends AssessmentQuestionsEvent {
  final String question2;

  SaveQuestion2Event({required this.question2});
}

class SaveQuestion3Event extends AssessmentQuestionsEvent {
  final String question3;

  SaveQuestion3Event({required this.question3});
}

class SaveQuestion4Event extends AssessmentQuestionsEvent {
  final String question4;

  SaveQuestion4Event({required this.question4});
}

class SaveQuestion5Event extends AssessmentQuestionsEvent {
  final String question5;

  SaveQuestion5Event({required this.question5});
}

class SaveQuestion6Event extends AssessmentQuestionsEvent {
  final String question6;

  SaveQuestion6Event({required this.question6});
}
