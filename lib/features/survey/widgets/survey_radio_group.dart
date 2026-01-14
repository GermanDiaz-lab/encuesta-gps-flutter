import 'package:flutter/material.dart';

class SurveyRadioGroup extends StatelessWidget {
  const SurveyRadioGroup({
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
          final groupValue = value.text.isEmpty ? null : value.text;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ...options.map(
                (option) => RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  title: Text(option),
                  value: option,
                  groupValue: groupValue,
                  onChanged: (selection) {
                    if (selection != null) {
                      controller.text = selection;
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
