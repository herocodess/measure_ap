import 'package:kochanet_measure_app/core/exceptions/failure_response.dart';
import 'package:kochanet_measure_app/core/utils/typedefs.dart';
import 'package:kochanet_measure_app/features/home/data/models/assessment_model.dart';
import 'package:kochanet_measure_app/features/home/data/models/create_assessment_model.dart';
import 'package:kochanet_measure_app/features/home/data/models/update_assessment_model.dart';
import 'package:kochanet_measure_app/features/home/data/repository/home_repository.dart';
import 'package:kochanet_measure_app/features/home/data/service/home_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this.dataSource);
  final HomeDataSource dataSource;
  @override
  ResponseFormat<FailureResponse, String> createAssessment(
      CreateAssessmentModel data) async {
    return dataSource.createAssessment(data);
  }

  @override
  ResponseFormat<FailureResponse, List<AssessmentModel>>
      getAllAssessments() async {
    return dataSource.getAllAssessments();
  }

  @override
  ResponseFormat<FailureResponse, void> updateAssessment(
      String id, UpdateAssessmentModel data) {
    return dataSource.updateAssessment(id, data);
  }
}
