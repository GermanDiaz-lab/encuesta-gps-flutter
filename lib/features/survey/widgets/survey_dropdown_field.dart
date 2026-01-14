import 'package:flutter/material.dart';

class SurveyDropdownField extends StatelessWidget {
  const SurveyDropdownField({
    super.key,
    required this.label,
    required this.controller,
    required this.options,
  });

  final String label;
  final TextEditingController controller;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, _) {
          final currentValue = options.contains(value.text)
              ? value.text
              : (options.isNotEmpty ? options.first : null);
          return DropdownButtonFormField<String>(
            value: currentValue,
            items: options
                .map(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ),
                )
                .toList(),
            onChanged: (selection) {
              if (selection != null) {
                controller.text = selection;
              }
            },
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
          );
        },
      ),
    );
  }
}
