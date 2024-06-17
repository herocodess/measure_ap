import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kochanet_measure_app/features/home/presentation/bloc/assessment_questions_bloc.dart';
import 'package:kochanet_measure_app/features/home/presentation/bloc/home_bloc.dart';

class AppBlocProviders {
  static List<BlocProvider> providers = [
    BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(),
    ),
    BlocProvider<AssessmentQuestionsBloc>(
      create: (BuildContext context) => AssessmentQuestionsBloc(),
    ),
  ];
}
