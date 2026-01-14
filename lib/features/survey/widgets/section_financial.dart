import 'package:flutter/material.dart';

import '../survey_controller.dart';
import 'survey_text_field.dart';

class SectionFinancial extends StatelessWidget {
  const SectionFinancial({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SurveyTextField(label: 'a65', controller: controller.controllerFor('a65')),
        SurveyTextField(label: 'a66', controller: controller.controllerFor('a66')),
        SurveyTextField(label: 'a67', controller: controller.controllerFor('a67')),
        SurveyTextField(label: 'a68', controller: controller.controllerFor('a68')),
        SurveyTextField(label: 'a69', controller: controller.controllerFor('a69')),
        SurveyTextField(label: 'a70', controller: controller.controllerFor('a70')),
        SurveyTextField(label: 'a71', controller: controller.controllerFor('a71')),
        SurveyTextField(label: 'a72', controller: controller.controllerFor('a72')),
        SurveyTextField(label: 'a73', controller: controller.controllerFor('a73')),
        SurveyTextField(label: 'a74', controller: controller.controllerFor('a74')),
        SurveyTextField(label: 'a75', controller: controller.controllerFor('a75')),
        SurveyTextField(label: 'a76', controller: controller.controllerFor('a76')),
        SurveyTextField(label: 'a77', controller: controller.controllerFor('a77')),
        SurveyTextField(label: 'a78', controller: controller.controllerFor('a78')),
        SurveyTextField(label: 'a79', controller: controller.controllerFor('a79')),
        SurveyTextField(label: 'a80', controller: controller.controllerFor('a80')),
      ],
    );
  }
}
