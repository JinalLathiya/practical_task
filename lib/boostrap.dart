import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical/src/core/dependency/dependency_helper.dart';
import 'package:practical/src/data/repository/comman_repository.dart';
import 'package:practical/src/localization/generated/l10n.dart';
import 'package:practical/src/presentation/ui/language_selection/logic/localization_bloc.dart';

import 'src/presentation/resources/log.dart';

typedef AsyncAppBuilder = FutureOr<Widget> Function();

Future<void> bootstrap(AsyncAppBuilder builder) async {
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final dependencyHelper = DependencyHelper.instance;
      await dependencyHelper.initialize();
      _configureSystemUi().ignore();

      final app = await builder();
      runApp(
        RepositoryProvider(
          create: (context) {
            return CommonRepository(localStorageService: dependencyHelper.get(), apiService: dependencyHelper.get());
          },
          child: BlocProvider(
            create: (context) {
              return LocalizationBloc.fromSystem(
                localizationsDelegate: AppLocalizations.delegate,
                commonRepository: RepositoryProvider.of(context),
              );
            },
            child: app,
          ),
        ),
      );
    },
    (error, stackTrace) {
      Log.debug(error);
      Log.debug(stackTrace);
    },
  );
}

Future<void> _configureSystemUi() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemStatusBarContrastEnforced: false,
    ),
  );
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}
