// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'assessment_questions_event.dart';
part 'assessment_questions_state.dart';

class AssessmentQuestionsBloc
    extends Bloc<AssessmentQuestionsEvent, AssessmentQuestions> {
  AssessmentQuestionsBloc()
      : super(
          AssessmentQuestions.empty(),
        ) {
    on<SaveQuestion1Event>((event, emit) {
      final x = state;
      emit(x.copyWith(question1: event.question1));
    });
    on<SaveQuestion2Event>((event, emit) {
      final x = state;
      emit(x.copyWith(question2: event.question2));
    });
    on<SaveQuestion3Event>((event, emit) {
      final x = state;
      emit(x.copyWith(question3: event.question3));
    });
    on<SaveQuestion4Event>((event, emit) {
      final x = state;
      emit(x.copyWith(question4: event.question4));
    });
    on<SaveQuestion5Event>((event, emit) {
      final x = state;
      emit(x.copyWith(question5: event.question5));
    });
    on<SaveQuestion6Event>((event, emit) {
      final x = state;
      emit(x.copyWith(question6: event.question6));
    });
  }
}

class AssessmentQuestions {
  final String question1;
  final String question2;
  final String question3;
  final String question4;
  final String question5;
  final String question6;

  AssessmentQuestions({
    required this.question1,
    required this.question2,
    required this.question3,
    required this.question4,
    required this.question5,
    required this.question6,
  });

  AssessmentQuestions copyWith({
    String? question1,
    String? question2,
    String? question3,
    String? question4,
    String? question5,
    String? question6,
  }) {
    return AssessmentQuestions(
      question1: question1 ?? this.question1,
      question2: question2 ?? this.question2,
      question3: question3 ?? this.question3,
      question4: question4 ?? this.question4,
      question5: question5 ?? this.question5,
      question6: question6 ?? this.question6,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question1': question1,
      'question2': question2,
      'question4': question4,
    };
  }

  factory AssessmentQuestions.empty() {
    return AssessmentQuestions(
        question1: '',
        question2: '',
        question4: '',
        question3: '',
        question5: '',
        question6: '');
  }
}
