// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Choose Language`
  String get languageSelectionTitle {
    return Intl.message(
      'Choose Language',
      name: 'languageSelectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose language which you prefer`
  String get languageSelectionContent {
    return Intl.message(
      'Choose language which you prefer',
      name: 'languageSelectionContent',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueButtonLabel {
    return Intl.message(
      'Continue',
      name: 'continueButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get loginScreenTitle {
    return Intl.message(
      'Welcome Back',
      name: 'loginScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hello there. sign in to continue`
  String get loginScreenContent {
    return Intl.message(
      'Hello there. sign in to continue',
      name: 'loginScreenContent',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailHintText {
    return Intl.message('Email', name: 'emailHintText', desc: '', args: []);
  }

  /// `Password`
  String get passwordHintText {
    return Intl.message(
      'Password',
      name: 'passwordHintText',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get rememberMeLabel {
    return Intl.message(
      'Remember Me',
      name: 'rememberMeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgetPasswordLabel {
    return Intl.message(
      'Forgot Password?',
      name: 'forgetPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `SIGN IN`
  String get signInButtonLabel {
    return Intl.message(
      'SIGN IN',
      name: 'signInButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get loginRichText1 {
    return Intl.message(
      'Don’t have an account?',
      name: 'loginRichText1',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get loginRichText2 {
    return Intl.message('Sign up', name: 'loginRichText2', desc: '', args: []);
  }

  /// `Please enter your email !!`
  String get requiredEmailError {
    return Intl.message(
      'Please enter your email !!',
      name: 'requiredEmailError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password !!`
  String get requiredPasswordError {
    return Intl.message(
      'Please enter your password !!',
      name: 'requiredPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email !!`
  String get invalidEmailError {
    return Intl.message(
      'Please enter a valid email !!',
      name: 'invalidEmailError',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long !!`
  String get passwordLengthError {
    return Intl.message(
      'Password must be at least 8 characters long !!',
      name: 'passwordLengthError',
      desc: '',
      args: [],
    );
  }

  /// `Login Successfully !!`
  String get loginSuccessMessage {
    return Intl.message(
      'Login Successfully !!',
      name: 'loginSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Search by name or pet ID`
  String get searchHintText {
    return Intl.message(
      'Search by name or pet ID',
      name: 'searchHintText',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to\nlogout?`
  String get logoutBottomSheetTitle {
    return Intl.message(
      'Are you sure you want to\nlogout?',
      name: 'logoutBottomSheetTitle',
      desc: '',
      args: [],
    );
  }

  /// `YES`
  String get yesButtonLabel {
    return Intl.message('YES', name: 'yesButtonLabel', desc: '', args: []);
  }

  /// `NO`
  String get noButtonLabel {
    return Intl.message('NO', name: 'noButtonLabel', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'hi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
