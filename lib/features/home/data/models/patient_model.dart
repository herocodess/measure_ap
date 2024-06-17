import 'dart:math';

class PatientModel {
  final String? id;
  final String fullname;
  final String age;
  final String gender;
  final String weight;

  PatientModel(
      {this.id,
      required this.fullname,
      required this.age,
      required this.gender,
      required this.weight});

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      fullname: json['fullname'],
      age: json['age'],
      gender: json['gender'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'age': age,
      'gender': gender,
      'weight': weight,
    };
  }
}

List<PatientModel> generatePatients() {
  List<String> maleNames = [
    'John Brookes',
    'Michael Scofield',
    'Robert Downey',
  ];

  List<String> femaleNames = [
    'Mary Cooper',
    'Patricia Olsman',
  ];

  List<PatientModel> patients = [];
  Random random = Random();

  for (int i = 0; i < maleNames.length; i++) {
    String id = 'M${i + 1}';
    String fullname = maleNames[i];
    String age = (random.nextInt(63) + 18).toString();
    String weight = (random.nextInt(71) + 50).toString();
    patients.add(PatientModel(
      id: id,
      fullname: fullname,
      age: age,
      gender: 'Male',
      weight: weight,
    ));
  }

  for (int i = 0; i < femaleNames.length; i++) {
    String id = 'F${i + 1}';
    String fullname = femaleNames[i];
    String age = (random.nextInt(63) + 18).toString();
    String weight = (random.nextInt(71) + 50).toString();
    patients.add(PatientModel(
      id: id,
      fullname: fullname,
      age: age,
      gender: 'Female',
      weight: weight,
    ));
  }

  return patients;
}
