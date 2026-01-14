import 'package:flutter/material.dart';

import '../survey_controller.dart';
import 'survey_text_field.dart';

class SectionIncome extends StatelessWidget {
  const SectionIncome({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Situacion Economica - FINANCIERA INGRESOS ${controller.numeroDeIngresos + 1}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        SurveyTextField(label: 'a57', controller: controller.controllerFor('a57')),
        SurveyTextField(label: 'a58', controller: controller.controllerFor('a58')),
        SurveyTextField(label: 'a59', controller: controller.controllerFor('a59')),
        SurveyTextField(label: 'a60', controller: controller.controllerFor('a60')),
        SurveyTextField(
          label: 'a61',
          controller: controller.controllerFor('a61'),
          keyboardType: TextInputType.number,
        ),
        SurveyTextField(label: 'a62', controller: controller.controllerFor('a62')),
        const SizedBox(height: 8),
        Text(
          'Fecha a63: ${controller.numeroDeIngresos < controller.fechaList.length ? controller.fechaList[controller.numeroDeIngresos].join('/') : 'Sin seleccionar'}',
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              controller.setIngresoDate(controller.numeroDeIngresos, date);
            }
          },
          child: const Text('Seleccionar fecha a63'),
        ),
        SurveyTextField(label: 'a64', controller: controller.controllerFor('a64')),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            final added = controller.addIngresoFromFields(
              empleoNumero: 0,
              ocupacionNumero: 0,
            );
            if (!added) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Maximo numero de Ingresos alcanzado')),
              );
            }
          },
          child: const Text('Nuevo importe'),
        ),
      ],
    );
  }
}
