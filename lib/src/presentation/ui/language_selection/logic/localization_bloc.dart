import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical/src/data/repository/comman_repository.dart';
import 'package:practical/src/presentation/ui/language_selection/logic/localization_event.dart';
import 'package:practical/src/presentation/ui/language_selection/logic/localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc(super.initialState, {required this.localizationsDelegate, required this.commonRepository}) {
    on<LocalizationUpdated>(_onLocalizationUpdated);
  }

  factory LocalizationBloc.fromSystem({
    required LocalizationsDelegate<Object> localizationsDelegate,
    required CommonRepository commonRepository,
  }) {
    Locale? effectiveLocale;

    final languageCodes = [commonRepository.getLanguageCode(), PlatformDispatcher.instance.locale.languageCode];

    for (final languageCode in languageCodes) {
      if (languageCode != null) {
        final locale = Locale.fromSubtags(languageCode: languageCode);
        if (localizationsDelegate.isSupported(locale)) {
          effectiveLocale = locale;
          break;
        }
      }
    }

    effectiveLocale ??= const Locale('en');
    final selectedLanguage = Language.values.firstWhere(
      (element) => element.languageCode == effectiveLocale?.languageCode,
      orElse: () => Language.english,
    );

    return LocalizationBloc(
      LocalizationState(selectedLanguage: selectedLanguage),
      localizationsDelegate: localizationsDelegate,
      commonRepository: commonRepository,
    );
  }

  final LocalizationsDelegate<Object> localizationsDelegate;
  final CommonRepository commonRepository;

  static LocalizationBloc of(BuildContext context, [bool listen = false]) {
    return BlocProvider.of<LocalizationBloc>(context, listen: listen);
  }

  void _onLocalizationUpdated(LocalizationUpdated event, Emitter<LocalizationState> emit) {
    final locale = Locale.fromSubtags(languageCode: event.language.languageCode);
    bool isSupported = localizationsDelegate.isSupported(locale);
    if (!isSupported) return;
    emit(state.copyWith(selectedLanguage: event.language));
    commonRepository.updateLanguageCode(event.language.languageCode);
  }
}
