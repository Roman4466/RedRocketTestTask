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
}
