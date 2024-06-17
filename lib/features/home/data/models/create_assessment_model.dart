import 'package:kochanet_measure_app/features/home/data/models/patient_model.dart';

class CreateAssessmentModel {
  String cognitiveStatus;
  String applicableMeasures;
  PatientModel patient;

  CreateAssessmentModel({
    required this.cognitiveStatus,
    required this.applicableMeasures,
    required this.patient,
  });

  Map<String, dynamic> toJson() {
    return {
      'cognitiveStatus': cognitiveStatus,
      'applicableMeasures': applicableMeasures,
      'patient': patient.toJson(),
    };
  }

  factory CreateAssessmentModel.fromJson(Map<String, dynamic> json) {
    return CreateAssessmentModel(
      cognitiveStatus: json['cognitiveStatus'],
      applicableMeasures: json['applicableMeasures'],
      patient: json['patient'],
    );
  }
}
