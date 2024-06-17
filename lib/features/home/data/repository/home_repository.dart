import 'package:kochanet_measure_app/core/exceptions/failure_response.dart';
import 'package:kochanet_measure_app/core/utils/typedefs.dart';
import 'package:kochanet_measure_app/features/home/data/models/assessment_model.dart';
import 'package:kochanet_measure_app/features/home/data/models/create_assessment_model.dart';
import 'package:kochanet_measure_app/features/home/data/models/update_assessment_model.dart';

abstract class HomeRepository {
  ResponseFormat<FailureResponse, String> createAssessment(
      CreateAssessmentModel data);

  ResponseFormat<FailureResponse, List<AssessmentModel>> getAllAssessments();

  ResponseFormat<FailureResponse, void> updateAssessment(
      String id, UpdateAssessmentModel data);
}
