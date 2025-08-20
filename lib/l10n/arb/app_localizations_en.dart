// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get redRocket => 'Red Rocket';

  @override
  String get testTask => 'Test Task';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInToAccount => 'Sign in to your account';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get signIn => 'Sign In';

  @override
  String get testCredentials => 'Test Credentials';

  @override
  String get testCredentialsText =>
      'Email: test@example.com\nPassword: password123';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get invalidEmailFormat => 'Invalid email format';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get home => 'Home';

  @override
  String get logout => 'Logout';

  @override
  String get welcomeBackComma => 'Welcome back,';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get profile => 'Profile';

  @override
  String get viewProfile => 'View profile';

  @override
  String get settings => 'Settings';

  @override
  String get appSettings => 'App settings';

  @override
  String get analytics => 'Analytics';

  @override
  String get viewStats => 'View stats';

  @override
  String get help => 'Help';

  @override
  String get getSupport => 'Get support';

  @override
  String get logoutConfirmTitle => 'Logout';

  @override
  String get logoutConfirmMessage => 'Are you sure you want to logout?';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String featureComingSoon(String feature) {
    return '$feature feature coming soon!';
  }

  @override
  String get errorNoConnection =>
      'No internet connection. Please check your network and try again.';

  @override
  String get errorConnectionTimeout => 'Connection timeout. Please try again.';

  @override
  String get errorServerTimeout =>
      'Server is taking too long to respond. Please try again.';

  @override
  String get errorServerError =>
      'Server error occurred. Please try again later.';

  @override
  String get errorInvalidCredentials =>
      'Invalid email or password. Please check your credentials and try again.';

  @override
  String get errorAccountLocked =>
      'Your account has been locked. Please contact support.';

  @override
  String get errorAccountNotFound =>
      'Account not found. Please check your email address.';

  @override
  String get errorTokenExpired =>
      'Your session has expired. Please log in again.';

  @override
  String get errorUnauthorizedAccess =>
      'You don\'t have permission to access this resource.';

  @override
  String get errorServiceUnavailable =>
      'Service is temporarily unavailable. Please try again later.';

  @override
  String get errorRateLimitExceeded =>
      'Too many requests. Please wait a moment and try again.';

  @override
  String get errorStorageError =>
      'Failed to save data locally. Please try again.';

  @override
  String get errorTokenSaveError =>
      'Failed to save authentication data. Please try logging in again.';

  @override
  String get errorUnknown => 'An unexpected error occurred. Please try again.';

  @override
  String get retry => 'Retry';

  @override
  String get retryConnection => 'Check Connection';

  @override
  String get retryRequest => 'Try Again';

  @override
  String get tryAgainLater => 'Try Later';

  @override
  String get pleaseFixErrors => 'Please fix the following errors:';

  @override
  String get formIsInvalid => 'Form is Invalid';

  @override
  String get connectionIssue => 'Connection Issue';

  @override
  String get authenticationFailed => 'Authentication Failed';

  @override
  String get validationError => 'Validation Error';

  @override
  String get generalError => 'Error';
}
