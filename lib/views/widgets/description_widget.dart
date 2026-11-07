import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  final String description;
  final bool showHeader;

  const DescriptionWidget({
    super.key,
    required this.description,
    this.showHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeader) ...[
            Text(
              'About the Destination',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
          ],
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.45,
              fontSize: 13.5,
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.85),
            ),
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
