import 'package:flutter/material.dart';

import '../survey_controller.dart';
import 'survey_section_header.dart';

class SectionSignature extends StatelessWidget {
  const SectionSignature({super.key, required this.controller});

  final SurveyController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SurveySectionHeader(
            title: 'Firma',
            subtitle: 'Dibuje la firma a continuación.',
          ),
          Builder(
            builder: (context) {
              return GestureDetector(
                onPanStart: (details) => _addPoint(context, details.globalPosition),
                onPanUpdate: (details) => _addPoint(context, details.globalPosition),
                onPanEnd: (_) => controller.addSignaturePoint(null),
                child: Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomPaint(
                    painter: _SignaturePainter(
                      points: List<Offset?>.of(controller.signaturePoints),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton.icon(
              onPressed: controller.signaturePoints.isEmpty
                  ? null
                  : controller.clearSignature,
              icon: const Icon(Icons.refresh),
              label: const Text('Limpiar'),
            ),
          ),
        ],
      ),
    );
  }

  void _addPoint(BuildContext context, Offset globalPosition) {
    final renderBox = context.findRenderObject();
    if (renderBox is RenderBox) {
      final localPosition = renderBox.globalToLocal(globalPosition);
      controller.addSignaturePoint(localPosition);
    }
  }
}

class _SignaturePainter extends CustomPainter {
  _SignaturePainter({required this.points});

  final List<Offset?> points;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      if (current != null && next != null) {
        canvas.drawLine(current, next, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SignaturePainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
