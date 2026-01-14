import 'package:flutter/material.dart';

import '../data/survey_options.dart';
import '../survey_controller.dart';
import 'survey_checkbox.dart';
import 'survey_radio_group.dart';
import 'survey_section_header.dart';
import 'survey_text_field.dart';

class SectionServices extends StatelessWidget {
  const SectionServices({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SurveySectionHeader(
          title: 'Servicios',
          subtitle: 'Detalles de servicios y montos mensuales.',
        ),
        SurveyCheckbox(
          label: 'Luz',
          value: controller.checkboxValue('a81'),
          onChanged: (value) => controller.setCheckbox('a81', value ?? false),
        ),
        SurveyTextField(
          label: 'Monto mensual',
          controller: controller.controllerFor('a82'),
          keyboardType: TextInputType.number,
        ),
        SurveyRadioGroup(
          label: 'Formalidad de conexión',
          controller: controller.controllerFor('a83'),
          options: formalidadOptions,
        ),
        SurveyCheckbox(
          label: 'Agua',
          value: controller.checkboxValue('a84'),
          onChanged: (value) => controller.setCheckbox('a84', value ?? false),
        ),
        SurveyTextField(
          label: 'Monto mensual',
          controller: controller.controllerFor('a85'),
          keyboardType: TextInputType.number,
        ),
        SurveyRadioGroup(
          label: 'Formalidad de conexión',
          controller: controller.controllerFor('a86'),
          options: formalidadOptions,
        ),
        SurveyCheckbox(
          label: 'Cable',
          value: controller.checkboxValue('a87'),
          onChanged: (value) => controller.setCheckbox('a87', value ?? false),
        ),
        SurveyTextField(
          label: 'Monto mensual',
          controller: controller.controllerFor('a88'),
          keyboardType: TextInputType.number,
        ),
        SurveyRadioGroup(
          label: 'Formalidad de conexión',
          controller: controller.controllerFor('a89'),
          options: formalidadOptions,
        ),
        SurveyCheckbox(
          label: 'Internet',
          value: controller.checkboxValue('a90'),
          onChanged: (value) => controller.setCheckbox('a90', value ?? false),
        ),
        SurveyTextField(
          label: 'Monto mensual',
          controller: controller.controllerFor('a91'),
          keyboardType: TextInputType.number,
        ),
        SurveyRadioGroup(
          label: 'Formalidad de conexión',
          controller: controller.controllerFor('a92'),
          options: formalidadOptions,
        ),
        SurveyTextField(
          label: 'Observaciones',
          controller: controller.controllerFor('a93'),
          maxLines: 3,
        ),
      ],
    );
  }
}
