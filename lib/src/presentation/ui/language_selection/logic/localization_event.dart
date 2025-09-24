import 'localization_state.dart';

sealed class LocalizationEvent {
  const LocalizationEvent();
}

final class LocalizationUpdated extends LocalizationEvent {
  const LocalizationUpdated({required this.language});

  final Language language;
}
