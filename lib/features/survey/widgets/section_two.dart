import 'package:flutter/material.dart';

import '../data/survey_options.dart';
import '../survey_controller.dart';
import 'survey_radio_group.dart';
import 'survey_section_header.dart';
import 'survey_text_field.dart';

class SectionTwo extends StatelessWidget {
  const SectionTwo({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SurveySectionHeader(
          title: 'Encuesta Antecedentes',
          subtitle: 'Historial del grupo familiar y acceso a vivienda.',
        ),
        SurveyTextField(
          label: 'Antecedentes IPRODHA',
          controller: controller.controllerFor('a20'),
        ),
        SurveyTextField(
          label: 'Antecedentes vivienda IPRODHA',
          controller: controller.controllerFor('a21'),
        ),
        SurveyTextField(
          label: 'Antecedentes programa Mejor Vivir',
          controller: controller.controllerFor('a22'),
        ),
        SurveyTextField(
          label: 'Antecedentes vivienda rural',
          controller: controller.controllerFor('a23'),
        ),
        SurveyTextField(
          label: 'Otros antecedentes',
          controller: controller.controllerFor('a24'),
        ),
        SurveyTextField(
          label: 'Antecedente arreglo Mi Casa',
          controller: controller.controllerFor('a25'),
        ),
        SurveyTextField(
          label: 'Antecedentes lotes',
          controller: controller.controllerFor('a26'),
        ),
        SurveyRadioGroup(
          label: 'Cómo accede a la vivienda',
          controller: controller.controllerFor('a27'),
          options: accesoViviendaOptions,
        ),
      ],
    );
  }
}
