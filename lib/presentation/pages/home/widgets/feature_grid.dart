import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:red_rocket_test_task/l10n/l10n.dart';

import 'feature_card.dart';
import 'feature_dialog.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16.w,
      mainAxisSpacing: 16.h,
      children: [
        FeatureCard(
          icon: Icons.person_outline,
          title: l10n.profile,
          subtitle: l10n.viewProfile,
          onTap: () => _showFeatureDialog(context, l10n.profile),
        ),
        FeatureCard(
          icon: Icons.settings_outlined,
          title: l10n.settings,
          subtitle: l10n.appSettings,
          onTap: () => _showFeatureDialog(context, l10n.settings),
        ),
        FeatureCard(
          icon: Icons.analytics_outlined,
          title: l10n.analytics,
          subtitle: l10n.viewStats,
          onTap: () => _showFeatureDialog(context, l10n.analytics),
        ),
        FeatureCard(
          icon: Icons.help_outline,
          title: l10n.help,
          subtitle: l10n.getSupport,
          onTap: () => _showFeatureDialog(context, l10n.help),
        ),
      ],
    );
  }

  void _showFeatureDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => FeatureDialog(feature: feature),
    );
  }
}
