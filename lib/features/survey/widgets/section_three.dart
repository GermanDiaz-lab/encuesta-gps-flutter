import 'package:flutter/material.dart';

import '../data/survey_options.dart';
import '../survey_controller.dart';
import 'survey_checkbox.dart';
import 'survey_dropdown_field.dart';
import 'survey_section_header.dart';
import 'survey_text_field.dart';

class SectionThree extends StatelessWidget {
  const SectionThree({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SurveySectionHeader(
          title: 'Grupo Familiar: según Estado Ocupacional',
          subtitle: 'Datos del núcleo familiar y escolaridad.',
        ),
        SurveyTextField(
          label: 'DNI',
          controller: controller.controllerFor('a28'),
          keyboardType: TextInputType.number,
        ),
        SurveyTextField(
          label: 'DNI cónyuge',
          controller: controller.controllerFor('a29'),
          keyboardType: TextInputType.number,
        ),
        SurveyTextField(
          label: 'DNI hijo/s',
          controller: controller.controllerFor('a30'),
          keyboardType: TextInputType.number,
        ),
        SurveyTextField(
          label: 'Acta de matrimonio',
          controller: controller.controllerFor('a31'),
        ),
        SurveyTextField(
          label: 'Unión convivencial',
          controller: controller.controllerFor('a32'),
        ),
        SurveyTextField(
          label: 'Partidas NAC',
          controller: controller.controllerFor('a33'),
        ),
        SurveyTextField(
          label: 'Contacto telefónico',
          controller: controller.controllerFor('a34'),
          keyboardType: TextInputType.phone,
        ),
        SurveyTextField(
          label: 'Observación',
          controller: controller.controllerFor('a35'),
          maxLines: 3,
        ),
        Text(
          'Escolaridad',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SurveyCheckbox(
          label: 'Escolaridad',
          value: controller.checkboxValue('a36'),
          onChanged: (value) => controller.setCheckbox('a36', value ?? false),
        ),
        SurveyCheckbox(
          label: 'Escuela pública',
          value: controller.checkboxValue('a37'),
          onChanged: (value) => controller.setCheckbox('a37', value ?? false),
        ),
        SurveyCheckbox(
          label: 'Escuela privada',
          value: controller.checkboxValue('a41'),
          onChanged: (value) => controller.setCheckbox('a41', value ?? false),
        ),
        SurveyCheckbox(
          label: 'Gastos escolares',
          value: controller.checkboxValue('a42'),
          onChanged: (value) => controller.setCheckbox('a42', value ?? false),
        ),
        SurveyDropdownField(
          label: 'Seleccionar estado civil titular',
          controller: controller.controllerFor('a38'),
          options: civilOptions,
        ),
        SurveyDropdownField(
          label: 'Seleccionar estado civil cónyuge',
          controller: controller.controllerFor('a39'),
          options: civilOptions,
        ),
        SurveyTextField(
          label: 'Correo electrónico',
          controller: controller.controllerFor('a40'),
          keyboardType: TextInputType.emailAddress,
          hintText: '@',
        ),
      ],
    );
  }
}
