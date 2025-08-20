import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:red_rocket_test_task/l10n/l10n.dart';

import '../../../core/app_routes.dart';
import '../../../core/thema/app_colors.dart';
import '../../../core/thema/app_text_styles.dart';
import '../../../core/widgets/error_toast.dart';
import '../../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _isFormValid = false;
  bool _emailTouched = false;
  bool _passwordTouched = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus && !_emailTouched) {
        setState(() {
          _emailTouched = true;
        });
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus && !_passwordTouched) {
        setState(() {
          _passwordTouched = true;
        });
      }
    });
  }

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  void _moveToPasswordField() {
    _passwordFocusNode.requestFocus();
  }

  void _submitForm() {
    _passwordFocusNode.unfocus();
    _onLoginPressed();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go(AppRoutePaths.home);
        } else if (state is AuthError) {
          ErrorToast.show(
            context,
            error: state.error,
            onRetry: state.error.isRetryable
                ? () => context.read<AuthBloc>().add(const AuthRetryLastAction())
                : null,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Form(
              key: _formKey,
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
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => _moveToPasswordField(),
                    decoration: InputDecoration(
                      labelText: l10n.email,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    validator: _emailTouched ? (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.emailRequired;
                      }
                      if (!_isValidEmail(value)) {
                        return l10n.invalidEmailFormat;
                      }
                      return null;
                    } : null,
                    onChanged: (_) => _validateForm(),
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submitForm(),
                    decoration: InputDecoration(
                      labelText: l10n.password,
                      prefixIcon: const Icon(Icons.lock_outlined),
                    ),
                    validator: _passwordTouched ? (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.passwordRequired;
                      }
                      if (value.length < 6) {
                        return l10n.passwordMinLength;
                      }
                      return null;
                    } : null,
                    onChanged: (_) => _validateForm(),
                  ),
                  SizedBox(height: 24.h),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;

                      return GestureDetector(
                        onTap: () {
                          if (!isLoading) {
                            if (_isFormValid) {
                              _onLoginPressed();
                            } else {
                              _showFormErrors(context, l10n);
                            }
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                            color: isLoading || !_isFormValid
                                ? AppColors.primary.withValues(alpha: 0.6)
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
                                : Text(l10n.signIn, style: AppTextStyles.buttonLarge),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLoginPressed() {
    setState(() {
      _emailTouched = true;
      _passwordTouched = true;
    });

    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;

      context.read<AuthBloc>().add(AuthLoginRequested(email: email, password: password));
    }
  }

  void _showFormErrors(BuildContext context, dynamic l10n) {
    setState(() {
      _emailTouched = true;
      _passwordTouched = true;
    });

    _formKey.currentState!.validate();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.pleaseFixErrors),
        backgroundColor: AppColors.error,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateForm);
    _passwordController.removeListener(_validateForm);
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}