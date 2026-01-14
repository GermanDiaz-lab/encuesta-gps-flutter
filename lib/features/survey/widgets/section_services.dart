import 'package:flutter/material.dart';

import '../survey_controller.dart';
import 'survey_checkbox.dart';
import 'survey_text_field.dart';

class SectionServices extends StatelessWidget {
  const SectionServices({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SurveyCheckbox(
          label: 'a81',
          value: controller.checkboxValue('a81'),
          onChanged: (value) =>
              controller.setCheckbox('a81', value ?? false),
        ),
        SurveyTextField(label: 'a82', controller: controller.controllerFor('a82')),
        SurveyTextField(label: 'a83', controller: controller.controllerFor('a83')),
        SurveyCheckbox(
          label: 'a84',
          value: controller.checkboxValue('a84'),
          onChanged: (value) =>
              controller.setCheckbox('a84', value ?? false),
        ),
        SurveyTextField(label: 'a85', controller: controller.controllerFor('a85')),
        SurveyTextField(label: 'a86', controller: controller.controllerFor('a86')),
        SurveyCheckbox(
          label: 'a87',
          value: controller.checkboxValue('a87'),
          onChanged: (value) =>
              controller.setCheckbox('a87', value ?? false),
        ),
        SurveyTextField(label: 'a88', controller: controller.controllerFor('a88')),
        SurveyTextField(label: 'a89', controller: controller.controllerFor('a89')),
        SurveyCheckbox(
          label: 'a90',
          value: controller.checkboxValue('a90'),
          onChanged: (value) =>
              controller.setCheckbox('a90', value ?? false),
        ),
        SurveyTextField(label: 'a91', controller: controller.controllerFor('a91')),
        SurveyTextField(label: 'a92', controller: controller.controllerFor('a92')),
        SurveyTextField(label: 'a93', controller: controller.controllerFor('a93')),
      ],
    );
  }
}
