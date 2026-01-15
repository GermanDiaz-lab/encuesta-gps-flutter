import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'services/location_service.dart';
import 'services/imgur_service.dart';
import 'services/survey_sync_service.dart';
import 'survey_controller.dart';
import 'widgets/section_financial.dart';
import 'widgets/section_four.dart';
import 'widgets/section_income.dart';
import 'widgets/section_one.dart';
import 'widgets/section_plan.dart';
import 'widgets/section_services.dart';
import 'widgets/section_signature.dart';
import 'widgets/section_three.dart';
import 'widgets/section_two.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  static const routeName = '/survey';

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  late final SurveyController _controller;
  int _stepIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = SurveyController(
      locationService: LocationService(),
      syncService: SurveySyncService(
        imgurService: ImgurService(clientId: const String.fromEnvironment('IMGUR_CLIENT_ID')),
        firestore: FirebaseFirestore.instance,
      ),
    );
  }

  @override
  void dispose() {
    _controller.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sections = [
      SectionOne(controller: _controller),
      SectionTwo(controller: _controller),
      SectionThree(controller: _controller),
      SectionFour(controller: _controller),
      SectionIncome(controller: _controller),
      SectionFinancial(controller: _controller),
      SectionServices(controller: _controller),
      SectionPlan(controller: _controller),
      SectionSignature(controller: _controller),
    ];

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Encuesta'),
          ),
          body: Column(
            children: [
              Expanded(child: sections[_stepIndex]),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    if (_stepIndex > 0)
                      OutlinedButton(
                        onPressed: _handleBack,
                        child: const Text('Atrás'),
                      ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _stepIndex == sections.length - 1
                          ? _handleSubmit
                          : _handleNext,
                      child: Text(
                        _stepIndex == sections.length - 1
                            ? 'Finalizar'
                            : 'Siguiente',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleNext() {
    if (_stepIndex == 4) {
      final added = _controller.addIngresoFromFields(
        empleoNumero: 0,
        ocupacionNumero: 0,
      );
      if (!added) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Maximo numero de Ingresos alcanzado')),
        );
        return;
      }
    }
    setState(() {
      _stepIndex += 1;
    });
  }

  void _handleBack() {
    if (_stepIndex == 4) {
      if (_controller.numeroDeIngresos == 0) {
        setState(() {
          _stepIndex -= 1;
        });
      } else {
        _controller.loadPreviousIngreso();
      }
      return;
    }
    if (_stepIndex == 5) {
      _controller.loadPreviousIngreso();
    }
    setState(() {
      _stepIndex -= 1;
    });
  }

  Future<void> _handleSubmit() async {
    final result = await _controller.submitSurvey();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result.message)),
    );
  }
}
