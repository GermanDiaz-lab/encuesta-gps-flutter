import 'package:flutter/material.dart';

import '../survey_controller.dart';
import 'survey_checkbox.dart';
import 'survey_text_field.dart';

class SectionThree extends StatelessWidget {
  const SectionThree({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SurveyTextField(label: 'a28', controller: controller.controllerFor('a28')),
        SurveyTextField(label: 'a29', controller: controller.controllerFor('a29')),
        SurveyTextField(label: 'a30', controller: controller.controllerFor('a30')),
        SurveyTextField(label: 'a31', controller: controller.controllerFor('a31')),
        SurveyTextField(label: 'a32', controller: controller.controllerFor('a32')),
        SurveyTextField(label: 'a33', controller: controller.controllerFor('a33')),
        SurveyTextField(label: 'a34', controller: controller.controllerFor('a34')),
        SurveyTextField(label: 'a35', controller: controller.controllerFor('a35')),
        SurveyCheckbox(
          label: 'a36',
          value: controller.checkboxValue('a36'),
          onChanged: (value) =>
              controller.setCheckbox('a36', value ?? false),
        ),
        SurveyCheckbox(
          label: 'a37',
          value: controller.checkboxValue('a37'),
          onChanged: (value) =>
              controller.setCheckbox('a37', value ?? false),
        ),
        SurveyCheckbox(
          label: 'a41',
          value: controller.checkboxValue('a41'),
          onChanged: (value) =>
              controller.setCheckbox('a41', value ?? false),
        ),
        SurveyCheckbox(
          label: 'a42',
          value: controller.checkboxValue('a42'),
          onChanged: (value) =>
              controller.setCheckbox('a42', value ?? false),
        ),
        SurveyTextField(label: 'a38', controller: controller.controllerFor('a38')),
        SurveyTextField(label: 'a39', controller: controller.controllerFor('a39')),
        SurveyTextField(label: 'a40', controller: controller.controllerFor('a40')),
      ],
    );
  }
}
