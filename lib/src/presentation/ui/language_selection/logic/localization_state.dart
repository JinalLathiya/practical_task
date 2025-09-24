import 'package:equatable/equatable.dart';

class LocalizationState extends Equatable {
  const LocalizationState({required this.selectedLanguage});

  final Language selectedLanguage;

  @override
  List<Object?> get props => [selectedLanguage];

  LocalizationState copyWith({Language? selectedLanguage}) {
    return LocalizationState(selectedLanguage: selectedLanguage ?? this.selectedLanguage);
  }
}

enum Language {
  english(name: 'English', languageCode: 'en'),
  hindi(name: 'हिन्दी', languageCode: 'hi');

  const Language({required this.name, required this.languageCode});

  final String name;
  final String languageCode;
}
