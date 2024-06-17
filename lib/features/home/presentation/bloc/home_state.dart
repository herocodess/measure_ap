part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class CreateAssessmentLoadingState extends HomeState {}

class CreateAssessmentSuccessState extends HomeState {
  final String id;

  CreateAssessmentSuccessState({required this.id});
}

class CreateAssessmentFailureState extends HomeState {
  final String error;

  CreateAssessmentFailureState({required this.error});
}

class GetAllAssessmentsLoadingState extends HomeState {}

class GetAllAssessmentsSuccessState extends HomeState {
  final List<AssessmentModel> assessments;

  GetAllAssessmentsSuccessState({required this.assessments});
}

class GetAllAssessmentsFailureState extends HomeState {
  final String error;

  GetAllAssessmentsFailureState({required this.error});
}

class UpdateAssessmentsLoadingState extends HomeState {}

class UpdateAssessmentsSuccessState extends HomeState {}

class UpdateAssessmntsFailureState extends HomeState {
  final String error;

  UpdateAssessmntsFailureState({required this.error});
}
