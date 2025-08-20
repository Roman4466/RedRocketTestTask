import 'package:flutter/material.dart';
import 'package:red_rocket_test_task/l10n/l10n.dart';

class FeatureDialog extends StatelessWidget {
  final String feature;

  const FeatureDialog({
    super.key,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Text(feature),
      content: Text(l10n.featureComingSoon(feature)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.ok),
        ),
      ],
    );
  }
}