import 'package:flutter/material.dart';

import '../data/survey_options.dart';
import '../survey_controller.dart';
import 'survey_checkbox.dart';
import 'survey_radio_group.dart';
import 'survey_section_header.dart';
import 'survey_text_field.dart';

class SectionFour extends StatelessWidget {
  const SectionFour({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SurveySectionHeader(
          title: 'Situación de Salud',
          subtitle: 'Cobertura médica, discapacidad y observaciones.',
        ),
        SurveyTextField(
          label: 'Obra social',
          controller: controller.controllerFor('a43'),
        ),
        SurveyCheckbox(
          label: 'Tiene CUD',
          value: controller.checkboxValue('a49'),
          onChanged: (value) => controller.setCheckbox('a49', value ?? false),
        ),
        SurveyTextField(
          label: 'Vigencia',
          controller: controller.controllerFor('a50'),
        ),
        SurveyRadioGroup(
          label: 'Discapacidad',
          controller: controller.controllerFor('a44'),
          options: discapacidadOptions,
        ),
        SurveyTextField(
          label: 'Diagnóstico',
          controller: controller.controllerFor('a45'),
          maxLines: 3,
        ),
        SurveyCheckbox(
          label: 'Silla de ruedas',
          value: controller.checkboxValue('a46'),
          onChanged: (value) => controller.setCheckbox('a46', value ?? false),
        ),
        SurveyCheckbox(
          label: 'Muletas',
          value: controller.checkboxValue('a47'),
          onChanged: (value) => controller.setCheckbox('a47', value ?? false),
        ),
        SurveyCheckbox(
          label: 'Andador',
          value: controller.checkboxValue('a48'),
          onChanged: (value) => controller.setCheckbox('a48', value ?? false),
        ),
        SurveyTextField(
          label: 'Otros aparatos para movilidad asistida',
          controller: controller.controllerFor('a51'),
        ),
        SurveyTextField(
          label: 'Observación',
          controller: controller.controllerFor('a52'),
          maxLines: 3,
        ),
        SurveyCheckbox(
          label: 'Transplantado',
          value: controller.checkboxValue('a53'),
          onChanged: (value) => controller.setCheckbox('a53', value ?? false),
        ),
        SurveyCheckbox(
          label: 'Carnet',
          value: controller.checkboxValue('a55'),
          onChanged: (value) => controller.setCheckbox('a55', value ?? false),
        ),
        SurveyCheckbox(
          label: 'Lista de espera',
          value: controller.checkboxValue('a56'),
          onChanged: (value) => controller.setCheckbox('a56', value ?? false),
        ),
        SurveyTextField(
          label: 'Observaciones',
          controller: controller.controllerFor('a54'),
          maxLines: 3,
        ),
      ],
    );
  }
}
