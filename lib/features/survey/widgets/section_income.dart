import 'package:flutter/material.dart';

import '../data/survey_options.dart';
import '../survey_controller.dart';
import 'survey_dropdown_field.dart';
import 'survey_section_header.dart';
import 'survey_text_field.dart';

class SectionIncome extends StatelessWidget {
  const SectionIncome({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    final index = controller.numeroDeIngresos;
    final fechaValue = index < controller.fechaList.length
        ? controller.fechaList[index].join('/')
        : 'Sin seleccionar';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SurveySectionHeader(
          title: 'Situación Económica - Ingresos',
          subtitle: 'Registro de ingreso ${index + 1}.',
        ),
        SurveyTextField(
          label: 'Nombre',
          controller: controller.controllerFor('a57'),
        ),
        SurveyDropdownField(
          label: 'Seleccionar categoría laboral',
          controller: controller.controllerFor('a58'),
          options: employmentOptions,
        ),
        SurveyDropdownField(
          label: 'Seleccionar ocupación',
          controller: controller.controllerFor('a59'),
          options: occupationOptions,
        ),
        SurveyTextField(
          label: 'Teléfono',
          controller: controller.controllerFor('a60'),
          keyboardType: TextInputType.phone,
        ),
        SurveyTextField(
          label: 'Ingresos',
          controller: controller.controllerFor('a61'),
          keyboardType: TextInputType.number,
        ),
        SurveyTextField(
          label: 'Domicilio',
          controller: controller.controllerFor('a62'),
        ),
        Text(
          'Fecha del recibo',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                fechaValue,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            FilledButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  controller.setIngresoDate(index, date);
                }
              },
              child: const Text('Seleccionar fecha'),
            ),
          ],
        ),
        SurveyTextField(
          label: 'Lugar',
          controller: controller.controllerFor('a64'),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {
            final added = controller.addIngresoFromFields(
              empleoNumero: 0,
              ocupacionNumero: 0,
            );
            if (!added) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Máximo número de ingresos alcanzado'),
                ),
              );
            }
          },
          icon: const Icon(Icons.add),
          label: const Text('Guardar ingreso y agregar otro'),
        ),
      ],
    );
  }
}
