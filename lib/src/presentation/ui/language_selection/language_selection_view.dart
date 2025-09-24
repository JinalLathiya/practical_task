import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:practical/src/core/extensions/extensions.dart';
import 'package:practical/src/localization/generated/l10n.dart';
import 'package:practical/src/presentation/resources/assets.dart';
import 'package:practical/src/presentation/resources/size_constants.dart';
import 'package:practical/src/presentation/ui/language_selection/logic/localization_bloc.dart';
import 'package:practical/src/presentation/ui/language_selection/logic/localization_event.dart';
import 'package:practical/src/presentation/ui/language_selection/logic/localization_state.dart';

class LanguageSelectionView extends StatefulWidget {
  const LanguageSelectionView({super.key});

  @override
  State<LanguageSelectionView> createState() => _LanguageSelectionViewState();
}

class _LanguageSelectionViewState extends State<LanguageSelectionView> {
  @override
  Widget build(BuildContext context) {
    final selectedLanguage = context.select<LocalizationBloc, Language>((value) => value.state.selectedLanguage);
    final theme = context.theme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Upper Image View
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(200)),
                  image: DecorationImage(
                    image: AssetImage(AppImages.bgImage),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    colorFilter: ColorFilter.mode(theme.colorScheme.primary.withOpacity(0.5), BlendMode.color),
                  ),
                ),
              ),
              Positioned(
                bottom: -25,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(color: theme.shadowColor.withOpacity(0.2), blurRadius: 8, offset: Offset(0, 4)),
                    ],
                  ),
                  child: Image.asset(AppImages.appIcon),
                ),
              ),
            ],
          ),
          Gap(60),

          //Language Selection
          Column(
            children: [
              Text(l10n.languageSelectionTitle, style: theme.textTheme.headlineMedium),
              Gap(8),
              Text(
                l10n.languageSelectionContent,
                style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              Gap(40),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Spacing.normal),
                child: RadioGroup(
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<LocalizationBloc>().add(LocalizationUpdated(language: value));
                    }
                  },
                  child: Column(
                    spacing: 20,
                    children: [
                      _LanguageTile(language: Language.english),
                      _LanguageTile(language: Language.hindi),
                    ],
                  ),
                ),
              ),
              Gap(40),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.normal),
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/login'),
              child: Text(l10n.continueButtonLabel),
            ),
          ),
        ],
      ),
    );
  }
}

// Language Selection Tile
class _LanguageTile extends StatelessWidget {
  const _LanguageTile({required this.language});

  final Language language;

  @override
  Widget build(BuildContext context) {
    bool selected = context.select<LocalizationBloc, bool>((value) => value.state.selectedLanguage == language);
    final theme = context.theme;

    return Material(
      type: MaterialType.transparency,
      child: RadioListTile(
        shape: RoundedRectangleBorder(
          borderRadius: ShapeBorderRadius.large,
          side: BorderSide(color: selected ? theme.colorScheme.primary : theme.colorScheme.outline),
        ),
        controlAffinity: ListTileControlAffinity.trailing,
        tileColor: selected ? theme.colorScheme.primaryContainer : theme.colorScheme.surfaceContainer,
        contentPadding: const EdgeInsets.symmetric(horizontal: Spacing.normal, vertical: Spacing.small),
        title: Text(language.name),
        value: language,
      ),
    );
  }
}
