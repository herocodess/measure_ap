// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:kochanet_measure_app/core/managers/app_manager.dart';
import 'package:kochanet_measure_app/features/home/data/models/assessment_model.dart';
import 'package:kochanet_measure_app/features/home/data/models/create_assessment_model.dart';
import 'package:kochanet_measure_app/features/home/data/models/update_assessment_model.dart';
import 'package:kochanet_measure_app/features/home/data/repository/home_repository_impl.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : _homeRepository = locator.get<HomeRepositoryImpl>(),
        super(HomeInitial()) {
    on<CreateAssessmentEvent>((event, emit) async {
      emit(CreateAssessmentLoadingState());

      final response = await _homeRepository.createAssessment(event.data);
      response.fold(
        (l) => emit(CreateAssessmentFailureState(error: l.message.toString())),
        (r) => emit(CreateAssessmentSuccessState(id: r)),
      );
    });

    on<GetAllAssessmentsEvents>((event, emit) async {
      emit(GetAllAssessmentsLoadingState());

      final response = await _homeRepository.getAllAssessments();
      response.fold(
        (l) => emit(GetAllAssessmentsFailureState(error: l.message.toString())),
        (r) => emit(GetAllAssessmentsSuccessState(assessments: r)),
      );
    });

    on<UpdateAssessmentsEvents>((event, emit) async {
      emit(UpdateAssessmentsLoadingState());

      final response =
          await _homeRepository.updateAssessment(event.id, event.assessment);
      response.fold(
        (l) => emit(UpdateAssessmntsFailureState(error: l.message.toString())),
        (r) => emit(UpdateAssessmentsSuccessState()),
      );
    });
  }

  final HomeRepositoryImpl _homeRepository;
}
