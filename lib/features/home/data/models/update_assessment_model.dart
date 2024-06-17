import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateAssessmentModel {
  String? question1Answer;
  String? question2Answer;
  String? question3Answer;
  String? question4Answer;
  String? question5Answer;
  String? question6Answer;
  double? totalScore;

  UpdateAssessmentModel({
    this.question1Answer,
    this.question2Answer,
    this.question3Answer,
    this.question4Answer,
    this.question5Answer,
    this.question6Answer,
    this.totalScore,
  });

  factory UpdateAssessmentModel.fromJson(Map<String, dynamic> json) {
    return UpdateAssessmentModel(
      question1Answer: json['question1Answer'],
      question2Answer: json['question2Answer'],
      question3Answer: json['question3Answer'],
      question4Answer: json['question4Answer'],
      question5Answer: json['question5Answer'],
      question6Answer: json['question6Answer'],
      totalScore: json['totalScore'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question1Answer'] = question1Answer;
    data['question2Answer'] = question2Answer;
    data['question3Answer'] = question3Answer;
    data['question4Answer'] = question4Answer;
    data['question5Answer'] = question5Answer;
    data['question6Answer'] = question6Answer;
    data['totalScore'] = totalScore;
    data['updatedAt'] = FieldValue.serverTimestamp();
    return data;
  }
}
