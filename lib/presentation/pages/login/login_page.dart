import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:red_rocket_test_task/l10n/l10n.dart';

import '../../../core/app_routes.dart';
import '../../../core/thema/app_colors.dart';
import '../../../core/thema/app_text_styles.dart';
import '../../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late FormGroup form;

  @override
  void initState() {
    super.initState();
    form = FormGroup({
      'email': FormControl<String>(validators: [Validators.required, Validators.email]),
      'password': FormControl<String>(validators: [Validators.required, Validators.minLength(6)]),
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go(AppRoutePaths.home);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: ReactiveForm(
              formGroup: form,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom -
                        48.w,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(Icons.rocket_launch, size: 64.w, color: AppColors.primary),
                        SizedBox(height: 20.h),
                        Text(
                          l10n.welcomeBack,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.welcomeTitle,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          l10n.signInToAccount,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.welcomeSubtitle,
                        ),
                        SizedBox(height: 40.h),
                        ReactiveTextField<String>(
                          formControlName: 'email',
                          decoration: InputDecoration(
                            labelText: l10n.email,
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validationMessages: {
                            ValidationMessage.required: (_) => l10n.emailRequired,
                            ValidationMessage.email: (_) => l10n.invalidEmailFormat,
                          },
                        ),
                        SizedBox(height: 16.h),
                        ReactiveTextField<String>(
                          formControlName: 'password',
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: l10n.password,
                            prefixIcon: const Icon(Icons.lock_outlined),
                          ),
                          validationMessages: {
                            ValidationMessage.required: (_) => l10n.passwordRequired,
                            ValidationMessage.minLength: (_) => l10n.passwordMinLength,
                          },
                        ),
                        SizedBox(height: 24.h),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            final isLoading = state is AuthLoading;

                            return ReactiveFormConsumer(
                              builder: (context, formGroup, child) {
                                final isFormValid = formGroup.valid;

                                return Column(
                                  children: [
                                    // Clickable container that handles both enabled and disabled states
                                    GestureDetector(
                                      onTap: () {
                                        if (!isLoading) {
                                          if (isFormValid) {
                                            _onLoginPressed();
                                          } else {
                                            _showFormErrors(context, formGroup, l10n);
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(vertical: 16.h),
                                        decoration: BoxDecoration(
                                          color: isLoading || !isFormValid
                                              ? AppColors.primary.withOpacity(0.6)
                                              : AppColors.primary,
                                          borderRadius: BorderRadius.circular(12.r),
                                        ),
                                        child: Center(
                                          child: isLoading
                                              ? SizedBox(
                                            height: 20.h,
                                            width: 20.w,
                                            child: const CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                AppColors.textOnPrimary,
                                              ),
                                            ),
                                          )
                                              : Text(
                                            l10n.signIn,
                                            style: AppTextStyles.buttonLarge,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.testCredentialsBg,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.testCredentialsBorder),
                          ),
                          child: Column(
                            children: [
                              Text(l10n.testCredentials, style: AppTextStyles.testCredentialsTitle),
                              SizedBox(height: 4.h),
                              Text(
                                l10n.testCredentialsText,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.testCredentialsBody,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLoginPressed() {
    if (form.valid) {
      final email = form.control('email').value as String;
      final password = form.control('password').value as String;

      context.read<AuthBloc>().add(AuthLoginRequested(email: email, password: password));
    }
  }

  void _showFormErrors(BuildContext context, FormGroup formGroup, dynamic l10n) {
    formGroup.markAllAsTouched();

    List<String> errorMessages = [];

    final emailControl = formGroup.control('email');
    if (emailControl.hasErrors) {
      if (emailControl.hasError(ValidationMessage.required)) {
        errorMessages.add(l10n.emailRequired);
      } else if (emailControl.hasError(ValidationMessage.email)) {
        errorMessages.add(l10n.invalidEmailFormat);
      }
    }

    final passwordControl = formGroup.control('password');
    if (passwordControl.hasErrors) {
      if (passwordControl.hasError(ValidationMessage.required)) {
        errorMessages.add(l10n.passwordRequired);
      } else if (passwordControl.hasError(ValidationMessage.minLength)) {
        errorMessages.add(l10n.passwordMinLength);
      }
    }

    if (errorMessages.isNotEmpty) {
      // Option 1: Show as SnackBar with all errors
      final errorText = errorMessages.join('\n');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.pleaseFixErrors,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),
              ...errorMessages.map((error) => Text('• $error')),
            ],
          ),
          backgroundColor: AppColors.error,
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Option 2: Show as Dialog (alternative approach)
      // _showErrorDialog(context, l10n, errorMessages);
    }
  }
  void _showErrorDialog(BuildContext context, dynamic l10n, List<String> errorMessages) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error_outline, color: AppColors.error),
              SizedBox(width: 8.w),
              Text(l10n.formIsInvalid),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.pleaseFixErrors),
              SizedBox(height: 12.h),
              ...errorMessages.map((error) => Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: AppColors.error)),
                    Expanded(child: Text(error)),
                  ],
                ),
              )),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.ok),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }
}
