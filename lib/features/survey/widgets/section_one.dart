import 'package:flutter/material.dart';

import '../data/cities.dart';
import '../data/survey_options.dart';
import '../survey_controller.dart';
import 'survey_dropdown_field.dart';
import 'survey_section_header.dart';
import 'survey_text_field.dart';

class SectionOne extends StatelessWidget {
  const SectionOne({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SurveySectionHeader(
          title: 'Encuesta Informe Socio Económico',
          subtitle: 'Datos generales de titular y vivienda.',
        ),
        SurveyTextField(
          label: 'Titular',
          controller: controller.controllerFor('a1'),
        ),
        SurveyTextField(
          label: 'Titular DNI',
          controller: controller.controllerFor('a2'),
          keyboardType: TextInputType.number,
        ),
        SurveyTextField(
          label: 'Ocupante',
          controller: controller.controllerFor('a3'),
        ),
        SurveyTextField(
          label: 'Ocupante DNI',
          controller: controller.controllerFor('a4'),
          keyboardType: TextInputType.number,
        ),
        SurveyTextField(
          label: 'Expte N.',
          controller: controller.controllerFor('a5'),
        ),
        SurveyTextField(
          label: 'Nota N.',
          controller: controller.controllerFor('a6'),
        ),
        SurveyDropdownField(
          label: 'Seleccionar sit. jurídica',
          controller: controller.controllerFor('a7'),
          options: juridicaOptions,
        ),
        _CityAutocomplete(controller: controller),
        SurveyTextField(
          label: 'Legajo CR',
          controller: controller.controllerFor('a9'),
          hintText: '/',
        ),
        SurveyDropdownField(
          label: 'Seleccionar título',
          controller: controller.controllerFor('a10'),
          options: tituloOptions,
        ),
        SurveyDropdownField(
          label: 'Seleccionar sit. hab.',
          controller: controller.controllerFor('a11'),
          options: situacionOptions,
        ),
        SurveyTextField(
          label: 'Identificación de la vivienda',
          controller: controller.controllerFor('a12'),
        ),
        SurveyTextField(
          label: 'Ampliación',
          controller: controller.controllerFor('a13'),
        ),
        SurveyTextField(
          label: 'Estado de deuda',
          controller: controller.controllerFor('a14'),
        ),
        SurveyTextField(
          label: 'Notificación de deuda',
          controller: controller.controllerFor('a15'),
        ),
        SurveyTextField(
          label: 'Tipología',
          controller: controller.controllerFor('a16'),
        ),
        SurveyTextField(
          label: 'Estado',
          controller: controller.controllerFor('a17'),
        ),
        const SizedBox(height: 8),
        Text(
          'Reside desde',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                controller.fecha.isEmpty
                    ? 'Sin seleccionar'
                    : controller.fecha,
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
                  controller.setMainDate(date);
                }
              },
              child: const Text('Seleccionar fecha'),
            ),
          ],
        ),
        SurveyTextField(
          label: 'Observación',
          controller: controller.controllerFor('a19'),
          maxLines: 3,
        ),
      ],
    );
  }
}

class _CityAutocomplete extends StatelessWidget {
  const _CityAutocomplete({required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue value) {
        if (value.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return encuestaCities.where(
          (city) => city.toLowerCase().contains(value.text.toLowerCase()),
        );
      },
      onSelected: (selection) {
        controller.controllerFor('a8').text = selection;
      },
      fieldViewBuilder: (context, textController, focusNode, onSubmitted) {
        textController.text = controller.controllerFor('a8').text;
        textController.addListener(() {
          controller.controllerFor('a8').text = textController.text;
        });
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            controller: textController,
            focusNode: focusNode,
            decoration: const InputDecoration(
              labelText: 'Localidad',
              border: OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }
}
