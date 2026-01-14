import 'package:flutter/material.dart';

class SurveySectionHeader extends StatelessWidget {
  const SurveySectionHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: theme.bodyMedium?.copyWith(color: theme.bodySmall?.color),
          ),
        ],
        const SizedBox(height: 12),
        const Divider(),
        const SizedBox(height: 8),
      ],
    );
  }
}
