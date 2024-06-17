import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kochanet_measure_app/core/exceptions/failure_response.dart';
import 'package:kochanet_measure_app/core/utils/firebase_helpers.dart';
import 'package:kochanet_measure_app/core/utils/typedefs.dart';
import 'package:kochanet_measure_app/features/home/data/models/assessment_model.dart';
import 'package:kochanet_measure_app/features/home/data/models/create_assessment_model.dart';
import 'package:kochanet_measure_app/features/home/data/models/update_assessment_model.dart';

class HomeDataSource {
  const HomeDataSource(this.store);
  final FirebaseFirestore store;

  ResponseFormat<FailureResponse, String> createAssessment(
      CreateAssessmentModel data) async {
    return runFirestoreOperation(() async {
      final res = await store.collection('assessments').add(data.toJson());
      return res.id;
    });
  }

  ResponseFormat<FailureResponse, List<AssessmentModel>>
      getAllAssessments() async {
    return runFirestoreOperation(() async {
      final querySnapshot = await store.collection('assessments').get();
      final assessments = querySnapshot.docs
          .map((doc) => AssessmentModel.fromJson(Map.from(doc.data()), doc.id))
          .toList();
      return assessments;
    });
  }

  ResponseFormat<FailureResponse, void> updateAssessment(
      String id, UpdateAssessmentModel data) async {
    return runFirestoreOperation(() async {
      await store.collection('assessments').doc(id).update(data.toJson());
    });
  }
}
