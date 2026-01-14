import 'package:flutter/material.dart';

class SurveyTextField extends StatelessWidget {
  const SurveyTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.hintText,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        minLines: minLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
