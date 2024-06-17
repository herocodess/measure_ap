import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kochanet_measure_app/core/router/app_routes.dart';
import 'package:kochanet_measure_app/core/router/navigation_service.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/helpers.dart';
import 'package:kochanet_measure_app/features/home/data/models/assessment_model.dart';
import 'package:kochanet_measure_app/features/home/data/models/create_assessment_model.dart';
import 'package:kochanet_measure_app/features/home/data/models/patient_model.dart';
import 'package:kochanet_measure_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:kochanet_measure_app/widgets/custom_alerts.dart';
import 'package:kochanet_measure_app/widgets/custom_autocomplete_widget.dart';
import 'package:kochanet_measure_app/widgets/custom_button.dart';
import 'package:kochanet_measure_app/widgets/custom_dropdown.dart';
import 'package:kochanet_measure_app/widgets/disabled_if_widget.dart';
import 'package:kochanet_measure_app/widgets/in_app_bar.dart';

class NewAssessmentView extends HookWidget {
  const NewAssessmentView({super.key, this.assessment});
  final AssessmentModel? assessment;

  @override
  Widget build(BuildContext context) {
    final selectedCognitiveStatus = useState<String>(
        assessment?.cognitiveStatus ?? 'Select cognitive status');
    final selectedApplicableMeasures = useState<String>(
        assessment?.applicableMeasures ?? 'Select applicable measures');
    final selectedPatient = useState<PatientModel?>(assessment?.patient);
    final patientController =
        useTextEditingController(text: assessment?.patient.fullname);
    var patientName = useState<String>(assessment?.patient.fullname ?? '');

    bool buttonDisabledCheck() {
      return selectedCognitiveStatus.value == 'Select cognitive Status' ||
          selectedApplicableMeasures.value == 'Select applicable measures' ||
          patientName.value.isEmpty;
    }

    final homeBloc = BlocProvider.of<HomeBloc>(context);

    return Scaffold(
      backgroundColor: AppColors.greyBg,
      bottomSheet: DisabledIfWidget(
        condition: buttonDisabledCheck(),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is CreateAssessmentLoadingState) {
              Helpers.showLoader(context, hasText: true);
            }
            if (state is CreateAssessmentFailureState) {
              Helpers.hideLoader(context);
              Alerts.show(state.error, context, isError: true);
            }

            if (state is CreateAssessmentSuccessState) {
              Helpers.hideLoader(context);
              pushTo(context, AppRoutes.assessmentSteps.path, extra: state.id);
            }
          },
          builder: (context, state) {
            return PrimaryGradientButton(
                onTap: buttonDisabledCheck()
                    ? null
                    : () {
                        if (assessment != null) {
                          pushTo(context, AppRoutes.assessmentSteps.path,
                              extra: assessment?.id);
                          return;
                        }

                        if (selectedPatient.value == null) {
                          Alerts.show('Please select a patient', context,
                              isError: true);
                          return;
                        }
                        final data = CreateAssessmentModel(
                            cognitiveStatus: selectedCognitiveStatus.value,
                            applicableMeasures:
                                selectedApplicableMeasures.value,
                            patient: selectedPatient.value!);
                        homeBloc.add(CreateAssessmentEvent(data: data));
                      },
                text: context.l10n.startAssessment);
          },
        ).paddingOnly(l: 20, r: 20, b: 50),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InAppBar(
                text: context.l10n.newAssessment,
              ),
              SizedBox(
                height: context.height * 0.04,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDropdown(
                        label: 'Cognitive Status',
                        selectedValue: selectedCognitiveStatus.value,
                        max: 400,
                        props: const [
                          'Select cognitive status',
                          'Cognition',
                          'Physical Examination',
                          'Diagnositic Tests',
                          'Treatment Plan',
                        ],
                        onchanged: (val) {
                          selectedCognitiveStatus.value = val ?? '';
                        },
                      ),
                      SizedBox(
                        height: context.height * 0.04,
                      ),
                      DisabledIfWidget(
                          condition: selectedCognitiveStatus.value ==
                              'Select cognitive status',
                          child: CustomDropdown(
                            label: 'Applicable Measures',
                            selectedValue: selectedApplicableMeasures.value,
                            max: 400,
                            props: const [
                              'Select applicable measures',
                              'SLUMS',
                              'MMSE',
                              'MoCA',
                              'GDS',
                            ],
                            onchanged: (val) {
                              selectedApplicableMeasures.value = val ?? '';
                            },
                          )),
                      SizedBox(
                        height: context.height * 0.04,
                      ),
                      DisabledIfWidget(
                        condition: selectedApplicableMeasures.value ==
                            'Select applicable measures',
                        child: CustomAutoCompleteWidget<PatientModel>(
                          label: 'Patient',
                          hint: 'Enter patient name or ID',
                          props: generatePatients(),
                          controller: patientController,
                          onItemSelected: (PatientModel value) {
                            selectedPatient.value = value;
                            patientController.text = value.fullname;
                            patientName.value = value.fullname;
                          },
                          filterProps: (String text) {
                            if (patientController.text.isEmpty) {
                              return [];
                            }
                            final list = generatePatients()
                                .where((element) => element.fullname
                                    .toLowerCase()
                                    .contains(text))
                                .toList();
                            return list;
                          },
                          getTextToDisplay: (PatientModel patient) {
                            return patient.fullname;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
