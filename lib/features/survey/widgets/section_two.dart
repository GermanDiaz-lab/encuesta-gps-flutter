import 'package:flutter/material.dart';

import '../survey_controller.dart';
import 'survey_text_field.dart';

class SectionTwo extends StatelessWidget {
  const SectionTwo({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SurveyTextField(label: 'a20', controller: controller.controllerFor('a20')),
        SurveyTextField(label: 'a21', controller: controller.controllerFor('a21')),
        SurveyTextField(label: 'a22', controller: controller.controllerFor('a22')),
        SurveyTextField(label: 'a23', controller: controller.controllerFor('a23')),
        SurveyTextField(label: 'a24', controller: controller.controllerFor('a24')),
        SurveyTextField(label: 'a25', controller: controller.controllerFor('a25')),
        SurveyTextField(label: 'a26', controller: controller.controllerFor('a26')),
        SurveyTextField(label: 'a27', controller: controller.controllerFor('a27')),
      ],
    );
  }
}
