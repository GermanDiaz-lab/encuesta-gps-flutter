import 'package:flutter/material.dart';

import '../data/cities.dart';
import '../survey_controller.dart';
import 'survey_text_field.dart';

class SectionOne extends StatelessWidget {
  const SectionOne({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SurveyTextField(label: 'a1', controller: controller.controllerFor('a1')),
        SurveyTextField(label: 'a2', controller: controller.controllerFor('a2')),
        SurveyTextField(label: 'a3', controller: controller.controllerFor('a3')),
        SurveyTextField(label: 'a4', controller: controller.controllerFor('a4')),
        SurveyTextField(label: 'a5', controller: controller.controllerFor('a5')),
        SurveyTextField(label: 'a6', controller: controller.controllerFor('a6')),
        SurveyTextField(label: 'a7', controller: controller.controllerFor('a7')),
        _CityAutocomplete(controller: controller),
        SurveyTextField(label: 'a9', controller: controller.controllerFor('a9')),
        SurveyTextField(label: 'a10', controller: controller.controllerFor('a10')),
        SurveyTextField(label: 'a11', controller: controller.controllerFor('a11')),
        SurveyTextField(label: 'a12', controller: controller.controllerFor('a12')),
        SurveyTextField(label: 'a13', controller: controller.controllerFor('a13')),
        SurveyTextField(label: 'a14', controller: controller.controllerFor('a14')),
        SurveyTextField(label: 'a15', controller: controller.controllerFor('a15')),
        SurveyTextField(label: 'a16', controller: controller.controllerFor('a16')),
        SurveyTextField(label: 'a17', controller: controller.controllerFor('a17')),
        SurveyTextField(label: 'a19', controller: controller.controllerFor('a19')),
        const SizedBox(height: 8),
        Text('Fecha a18: ${controller.fecha.isEmpty ? 'Sin seleccionar' : controller.fecha}'),
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
              controller.setMainDate(date);
            }
          },
          child: const Text('Seleccionar fecha a18'),
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
              labelText: 'a8',
              border: OutlineInputBorder(),
            ),
          ),
        );
      },
    );
  }
}
