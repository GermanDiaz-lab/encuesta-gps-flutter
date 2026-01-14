import 'package:flutter/material.dart';

import '../survey_controller.dart';
import 'survey_checkbox.dart';
import 'survey_text_field.dart';

class SectionFour extends StatelessWidget {
  const SectionFour({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SurveyTextField(label: 'a43', controller: controller.controllerFor('a43')),
        SurveyTextField(label: 'a44', controller: controller.controllerFor('a44')),
        SurveyTextField(label: 'a45', controller: controller.controllerFor('a45')),
        SurveyCheckbox(
          label: 'a46',
          value: controller.checkboxValue('a46'),
          onChanged: (value) =>
              controller.setCheckbox('a46', value ?? false),
        ),
        SurveyCheckbox(
          label: 'a47',
          value: controller.checkboxValue('a47'),
          onChanged: (value) =>
              controller.setCheckbox('a47', value ?? false),
        ),
        SurveyCheckbox(
          label: 'a48',
          value: controller.checkboxValue('a48'),
          onChanged: (value) =>
              controller.setCheckbox('a48', value ?? false),
        ),
        SurveyCheckbox(
          label: 'a49',
          value: controller.checkboxValue('a49'),
          onChanged: (value) =>
              controller.setCheckbox('a49', value ?? false),
        ),
        SurveyTextField(label: 'a50', controller: controller.controllerFor('a50')),
        SurveyTextField(label: 'a51', controller: controller.controllerFor('a51')),
        SurveyTextField(label: 'a52', controller: controller.controllerFor('a52')),
        SurveyCheckbox(
          label: 'a53',
          value: controller.checkboxValue('a53'),
          onChanged: (value) =>
              controller.setCheckbox('a53', value ?? false),
        ),
        SurveyTextField(label: 'a54', controller: controller.controllerFor('a54')),
        SurveyCheckbox(
          label: 'a55',
          value: controller.checkboxValue('a55'),
          onChanged: (value) =>
              controller.setCheckbox('a55', value ?? false),
        ),
        SurveyCheckbox(
          label: 'a56',
          value: controller.checkboxValue('a56'),
          onChanged: (value) =>
              controller.setCheckbox('a56', value ?? false),
        ),
      ],
    );
  }
}
