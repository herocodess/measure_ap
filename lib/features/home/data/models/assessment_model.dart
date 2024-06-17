import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kochanet_measure_app/features/home/data/models/patient_model.dart';

class AssessmentModel {
  String cognitiveStatus;
  String applicableMeasures;
  PatientModel patient;
  String id;
  String? question1Answer;
  String? question2Answer;
  String? question3Answer;
  String? question4Answer;
  String? question5Answer;
  String? question6Answer;
  double? totalScore;
  Timestamp? updatedAt;

  AssessmentModel({
    required this.cognitiveStatus,
    required this.applicableMeasures,
    required this.patient,
    required this.id,
    this.question1Answer,
    this.question2Answer,
    this.question3Answer,
    this.question4Answer,
    this.question5Answer,
    this.question6Answer,
    this.totalScore,
    this.updatedAt,
  });

  AssessmentModel.empty()
      : cognitiveStatus = '',
        applicableMeasures = '',
        patient = PatientModel(
          id: '',
          fullname: '',
          age: '',
          gender: '',
          weight: '',
        ),
        id = '',
        question1Answer = null,
        question2Answer = null,
        question3Answer = null,
        question4Answer = null,
        question5Answer = null,
        question6Answer = null,
        totalScore = 0;

  Map<String, dynamic> toJson() {
    return {
      'cognitiveStatus': cognitiveStatus,
      'applicableMeasures': applicableMeasures,
      'patient': patient,
      'question1Answer': question1Answer,
      'question2Answer': question2Answer,
      'question3Answer': question3Answer,
      'question4Answer': question4Answer,
      'question5Answer': question5Answer,
      'question6Answer': question6Answer,
      'totalScore': totalScore,
    };
  }

  bool get isComplete {
    return question1Answer != null &&
        question2Answer != null &&
        question3Answer != null &&
        question4Answer != null &&
        question5Answer != null &&
        question6Answer != null &&
        totalScore != 0;
  }

  factory AssessmentModel.fromJson(Map<String, dynamic> json, String id) {
    return AssessmentModel(
      cognitiveStatus: json['cognitiveStatus'],
      applicableMeasures: json['applicableMeasures'],
      patient: PatientModel.fromJson(json['patient']),
      id: id,
      question1Answer: json['question1Answer'],
      question2Answer: json['question2Answer'],
      question3Answer: json['question3Answer'],
      question4Answer: json['question4Answer'],
      question5Answer: json['question5Answer'],
      question6Answer: json['question6Answer'],
      totalScore: json['totalScore'],
      updatedAt: json['updatedAt'],
    );
  }
}
