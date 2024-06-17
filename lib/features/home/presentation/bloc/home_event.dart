part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class CreateAssessmentEvent extends HomeEvent {
  final CreateAssessmentModel data;

  CreateAssessmentEvent({required this.data});
}

class GetAllAssessmentsEvents extends HomeEvent {}

class UpdateAssessmentsEvents extends HomeEvent {
  final String id;
  final UpdateAssessmentModel assessment;

  UpdateAssessmentsEvents({required this.id, required this.assessment});
}
