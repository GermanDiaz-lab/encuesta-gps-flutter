import 'package:flutter/material.dart';

import '../survey_controller.dart';
import 'survey_text_field.dart';

class SectionPlan extends StatelessWidget {
  const SectionPlan({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SurveyTextField(label: 'a94', controller: controller.controllerFor('a94')),
        SurveyTextField(label: 'a95', controller: controller.controllerFor('a95')),
        SurveyTextField(label: 'a96', controller: controller.controllerFor('a96')),
        SurveyTextField(label: 'a97', controller: controller.controllerFor('a97')),
        SurveyTextField(label: 'a98', controller: controller.controllerFor('a98')),
        SurveyTextField(label: 'a99', controller: controller.controllerFor('a99')),
        SurveyTextField(label: 'a100', controller: controller.controllerFor('a100')),
        SurveyTextField(label: 'a101', controller: controller.controllerFor('a101')),
      ],
    );
  }
}
