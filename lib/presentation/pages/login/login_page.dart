import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:red_rocket_test_task/core/app_routes.dart';
import 'package:red_rocket_test_task/l10n/l10n.dart';

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
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
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
                        MediaQuery.of(context).padding.bottom - 48.w, // Account for padding
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(Icons.rocket_launch, size: 64.w, color: Colors.deepPurple),
                        SizedBox(height: 20.h),
                        Text(
                          l10n.welcomeBack,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          l10n.signInToAccount,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                        ),
                        SizedBox(height: 40.h),
                        ReactiveTextField<String>(
                          formControlName: 'email',
                          decoration: InputDecoration(
                            labelText: l10n.email,
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                            filled: true,
                            fillColor: Colors.white,
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
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validationMessages: {
                            ValidationMessage.required: (_) => l10n.passwordRequired,
                            ValidationMessage.minLength: (_) => l10n.passwordMinLength,
                          },
                        ),
                        SizedBox(height: 24.h),

                        // Login button
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            final isLoading = state is AuthLoading;

                            return ReactiveFormConsumer(
                              builder: (context, formGroup, child) {
                                return ElevatedButton(
                                  onPressed: isLoading || formGroup.invalid
                                      ? null
                                      : () => _onLoginPressed(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 16.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: isLoading
                                      ? SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                      : Text(
                                    l10n.signIn,
                                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.blue[200]!),
                          ),
                          child: Column(
                            children: [
                              Text(
                                l10n.testCredentials,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[800],
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                l10n.testCredentialsText,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.sp, color: Colors.blue[700]),
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

  @override
  void dispose() {
    form.dispose();
    super.dispose();
  }
}