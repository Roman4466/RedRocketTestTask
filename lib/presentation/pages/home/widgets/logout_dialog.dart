import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_rocket_test_task/l10n/l10n.dart';

import '../../../bloc/auth_bloc.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Text(l10n.logoutConfirmTitle),
      content: Text(l10n.logoutConfirmMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<AuthBloc>().add(const AuthLogoutRequested());
          },
          child: Text(l10n.logout),
        ),
      ],
    );
  }
}
