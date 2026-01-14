import 'package:flutter/material.dart';

import '../data/survey_options.dart';
import '../survey_controller.dart';
import 'survey_dropdown_field.dart';
import 'survey_section_header.dart';
import 'survey_text_field.dart';

class SectionFinancial extends StatelessWidget {
  const SectionFinancial({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SurveySectionHeader(
          title: 'Situación Económica - Financiera',
          subtitle: 'Titular y garante del hogar.',
        ),
        SurveyTextField(
          label: 'Principal pagador',
          controller: controller.controllerFor('a65'),
        ),
        SurveyTextField(
          label: 'DNI',
          controller: controller.controllerFor('a66'),
          keyboardType: TextInputType.number,
        ),
        SurveyTextField(
          label: 'Ingresos',
          controller: controller.controllerFor('a67'),
          keyboardType: TextInputType.number,
        ),
        SurveyDropdownField(
          label: 'Seleccionar categoría laboral',
          controller: controller.controllerFor('a68'),
          options: employmentOptions,
        ),
        const SizedBox(height: 8),
        Text(
          'Garante',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SurveyTextField(
          label: 'Nombre del garante',
          controller: controller.controllerFor('a69'),
        ),
        SurveyTextField(
          label: 'DNI',
          controller: controller.controllerFor('a70'),
          keyboardType: TextInputType.number,
        ),
        SurveyTextField(
          label: 'Ingresos',
          controller: controller.controllerFor('a71'),
          keyboardType: TextInputType.number,
        ),
        SurveyDropdownField(
          label: 'Seleccionar categoría laboral',
          controller: controller.controllerFor('a72'),
          options: employmentOptions,
        ),
        SurveyTextField(
          label: 'Declaración jurada',
          controller: controller.controllerFor('a73'),
        ),
        const SizedBox(height: 8),
        Text(
          'Titular: créditos vigentes',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SurveyTextField(
          label: 'Préstamos',
          controller: controller.controllerFor('a74'),
        ),
        SurveyTextField(
          label: 'Monto',
          controller: controller.controllerFor('a75'),
          keyboardType: TextInputType.number,
        ),
        SurveyTextField(
          label: 'Plazo',
          controller: controller.controllerFor('a76'),
        ),
        SurveyTextField(
          label: 'Tarjetas',
          controller: controller.controllerFor('a77'),
        ),
        SurveyTextField(
          label: 'Consumo mensual',
          controller: controller.controllerFor('a78'),
          keyboardType: TextInputType.number,
        ),
        SurveyDropdownField(
          label: 'Seleccionar tipo de tarjeta',
          controller: controller.controllerFor('a79'),
          options: tarjetaOptions,
        ),
        SurveyTextField(
          label: 'Observaciones',
          controller: controller.controllerFor('a80'),
          maxLines: 3,
        ),
      ],
    );
  }
}
