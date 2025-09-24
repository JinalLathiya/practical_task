import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:practical/src/localization/generated/l10n.dart';
import 'package:practical/src/presentation/resources/theme.dart';
import 'package:practical/src/presentation/ui/home/home_view.dart';
import 'package:practical/src/presentation/ui/language_selection/language_selection_view.dart';
import 'package:practical/src/presentation/ui/language_selection/logic/localization_bloc.dart';
import 'package:practical/src/presentation/ui/login/login_view.dart';

import 'boostrap.dart';
import 'src/presentation/ui/language_selection/logic/localization_state.dart';

void main() async {
  bootstrap(() => const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final language = context.select<LocalizationBloc, Language>((value) => value.state.selectedLanguage);
    final themes = AppTheme(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: themes.lightTheme,
      locale: Locale(language.languageCode),
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginView(),
        '/language-selection': (context) => const LanguageSelectionView(),
        '/login': (context) => const LoginView(),
        '/home': (context) => const HomeView(),
      },
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
