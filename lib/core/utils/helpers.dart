// ignore_for_file: depend_on_referenced_packages

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/enums.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/images.dart';
import 'package:kochanet_measure_app/features/home/data/models/assessment_model.dart';
import 'package:kochanet_measure_app/features/home/presentation/bloc/assessment_questions_bloc.dart';
import 'package:kochanet_measure_app/features/home/presentation/widgets/assessment_image_dialog.dart';
import 'package:kochanet_measure_app/widgets/custom_alerts.dart';
import 'package:kochanet_measure_app/widgets/custom_loader.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';

class Helpers {
  static Menu getSelectedMenu(StatefulNavigationShell? shell) {
    return switch (shell?.currentIndex ?? 0) {
      1 => Menu.patients,
      2 => Menu.history,
      3 => Menu.settings,
      0 || _ => Menu.home,
    };
  }

  static String getCurrentDayAndDate(DayDateOptions option) {
    DateTime now = DateTime.now();
    String dayOfWeek = DateFormat('EEEE').format(now);

    String formattedDate = DateFormat('d MMMM, y').format(now);

    return switch (option) {
      DayDateOptions.date => formattedDate,
      DayDateOptions.day || _ => dayOfWeek,
    };
  }

  static String parseTimeStampToReadableFormat(DateTime time) {
    DateFormat outputFormat = DateFormat("dd.MM.yyyy");

    String formattedDate = outputFormat.format(time);
    return formattedDate;
  }

  static String getAnswerStatus(List<int> indices) {
    return switch (indices) {
      _ when indices.contains(0) && indices.contains(2) => "Correct",
      _ => "Incorrect",
    };
  }

  static void showLoader(BuildContext context, {bool hasText = false}) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: false,
        pageBuilder: (BuildContext context, _, __) {
          return CustomLoader(
            hasText: hasText,
          );
        },
      ),
    );
  }

  static void saveDefaultAssessmentQuestions(AssessmentQuestionsBloc bloc) {
    bloc.add(SaveQuestion4Event(question4: 'Incorrect'));
    bloc.add(SaveQuestion5Event(question5: 'Incorrect'));
    bloc.add(SaveQuestion6Event(question6: 'Incorrect'));
  }

  static List<Map<String, String?>> getAssessmentQuestionsList(
      AssessmentModel assessment) {
    return [
      {
        'key': 'Question1',
        'value': assessment.question1Answer,
      },
      {
        'key': 'Question2',
        'value': assessment.question2Answer,
      },
      {
        'key': 'Question3',
        'value': assessment.question3Answer,
      },
      {
        'key': 'Question4',
        'value': assessment.question4Answer,
      },
      {
        'key': 'Question5',
        'value': assessment.question5Answer,
      },
      {
        'key': 'Question6',
        'value': assessment.question6Answer,
      },
    ];
  }

  static String getDOBFromAge(int age) {
    final currentDate = DateTime.now();
    final birthYear = currentDate.year - age;
    final dob = DateTime(birthYear, currentDate.month, currentDate.day);

    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(dob);
  }

  static List<Map<String, dynamic>> getPatientDetailsList(
      AssessmentModel assessment, BuildContext context) {
    return [
      {
        'title': context.l10n.patientDOBAge,
        'icon': AppImages.infoImg,
        'subtitle': assessment.patient.age,
        'hasSecondSubtitle': true,
        'secondSubtitle': getDOBFromAge(int.parse(assessment.patient.age)),
      },
      {
        'title': context.l10n.patientPhonenumber,
        'icon': AppImages.phoneImg,
        'subtitle': "+381601232246",
        'hasSecondSubtitle': false,
        'secondSubtitle': '',
      },
      {
        'title': context.l10n.patientAddress,
        'icon': AppImages.locationImg,
        'subtitle': "South Vest avenue street",
        'hasSecondSubtitle': false,
        'secondSubtitle': '',
      },
    ];
  }

  static String getStep4Percentage(int correctValue, int totalItems) {
    double percentage = (correctValue / totalItems) * 25;
    return switch (percentage) {
      25 => 'Correct',
      _ => 'Incorrect',
    };
  }

  static double getTotalScore(List<String> questions) {
    int correctCount = 0;

    for (String question in questions) {
      if (question.toLowerCase() == 'correct') {
        correctCount += 3;
      }
    }

    return correctCount.toDouble();
  }

  static Color getColorBasedOnText(String text) {
    return switch (text.toLowerCase()) {
      'correct' => AppColors.green500,
      'incorrect' || _ => AppColors.darkerRed,
    };
  }

  static void printDocument(
      ScreenshotController controller, BuildContext context) {
    controller.capture().then((Uint8List? image) {
      if (image != null) {
        Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
          final doc = pw.Document();
          final imageProvider = pw.MemoryImage(image);
          doc.addPage(
            pw.Page(
              build: (pw.Context context) {
                return pw.Center(child: pw.Image(imageProvider));
              },
            ),
          );
          return doc.save();
        });
      }
    }).catchError((onError) {
      Alerts.show(onError.toString(), isError: true, context);
    });
  }

  static void hideLoader(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showImageDialog(BuildContext context, {required String asset}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AssessmentImageDialogWidget(
        asset: asset,
      ),
    );
  }
}
