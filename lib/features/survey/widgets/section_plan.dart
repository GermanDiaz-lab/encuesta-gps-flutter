import 'package:flutter/material.dart';

import '../data/survey_options.dart';
import '../survey_controller.dart';
import 'survey_dropdown_field.dart';
import 'survey_section_header.dart';
import 'survey_text_field.dart';

class SectionPlan extends StatelessWidget {
  const SectionPlan({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SurveySectionHeader(
          title: 'Conclusión cuota modalidad regularización',
          subtitle: 'Resultado y tipo de cuota asignada.',
        ),
        Text(
          'Tipo de cuota',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SurveyTextField(
          label: 'Cuota social',
          controller: controller.controllerFor('a94'),
        ),
        SurveyTextField(
          label: 'Cuota provisoria',
          controller: controller.controllerFor('a95'),
        ),
        SurveyTextField(
          label: 'Cuota estándar',
          controller: controller.controllerFor('a96'),
        ),
        SurveyTextField(
          label: 'Plan venta',
          controller: controller.controllerFor('a97'),
        ),
        SurveyDropdownField(
          label: 'Seleccionar plan alquiler',
          controller: controller.controllerFor('a98'),
          options: alquilerOptions,
        ),
        SurveyTextField(
          label: 'Otros',
          controller: controller.controllerFor('a99'),
        ),
        SurveyTextField(
          label: 'Plazo de presentación de documentación',
          controller: controller.controllerFor('a100'),
        ),
        SurveyTextField(
          label: 'Observaciones',
          controller: controller.controllerFor('a101'),
          maxLines: 3,
        ),
      ],
    );
  }
}
