import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:practical/src/core/extensions/extensions.dart';
import 'package:practical/src/localization/generated/l10n.dart';
import 'package:practical/src/presentation/resources/assets.dart';
import 'package:practical/src/presentation/resources/size_constants.dart';
import 'package:practical/src/presentation/resources/svg_icon.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 120,
            padding: EdgeInsets.only(left: Spacing.normal, right: Spacing.normal, top: Spacing.xxLarge),
            decoration: BoxDecoration(
              color: Color(0xff01b5bf),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  ),
                ),
                Spacer(),
                Text(
                  "ClipCuts",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontFamily: 'Pattaya',
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () async {
                    final result = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.large),
                      builder: (context) => LogoutBottomSheet(),
                    );
                    if (result == true) {
                      Navigator.of(context).pushNamed("/login");
                    }
                  },
                  icon: SvgIcon(SvgIcons.logoutIcon, color: Colors.white, size: 30),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Spacing.normal),
              child: Column(
                spacing: Spacing.normal,
                children: [
                  Card(
                    elevation: 4,
                    child: TextField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).searchHintText,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(Spacing.small),
                          child: SvgIcon(SvgIcons.searchIcon, size: 20),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: ShapeBorderRadius.medium,
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  ListView.separated(
                    padding: EdgeInsets.only(bottom: Spacing.xLarge),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => _dataTile(),
                    separatorBuilder: (context, index) => Gap(Spacing.normal),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.normal, vertical: Spacing.large),
      decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: ShapeCornerRadius.extraLarge)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(color: theme.colorScheme.outline, borderRadius: ShapeBorderRadius.normal),
          ),
          const Gap(Spacing.xxLarge),
          Text(l10n.logoutBottomSheetTitle, textAlign: TextAlign.center, style: theme.textTheme.headlineMedium),
          Gap(Spacing.xxLarge),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.surfaceContainerHighest),
                  child: Text(l10n.yesButtonLabel, style: TextStyle(color: theme.colorScheme.onSurface)),
                ),
              ),
              Gap(Spacing.normal),
              Expanded(
                child: ElevatedButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.noButtonLabel)),
              ),
            ],
          ),
          Gap(Spacing.xxxLarge),
        ],
      ),
    );
  }
}

class _dataTile extends StatelessWidget {
  const _dataTile();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      padding: EdgeInsets.all(Spacing.normal),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: ShapeBorderRadius.normal,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 24,
            offset: Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: ShapeBorderRadius.small,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1537151608828-ea2b11777ee8?q=80&w=994&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    ),
                  ),
                ),
              ),
              Gap(Spacing.normal),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: Spacing.xSmall,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Charlie", style: theme.textTheme.bodyLarge),
                      Container(
                        margin: EdgeInsets.only(left: Spacing.small),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary.withOpacity(0.1),
                          borderRadius: ShapeBorderRadius.normal,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Spacing.small),
                          child: Text(
                            "Male",
                            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.secondary),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "ID:A0001",
                    style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              infoTile("Mating date", "12/11/2001", theme),
              Spacer(),
              infoTile("Breeding Partner", "Emmy", theme),
              Spacer(),
              infoTile("Pregnancy", "Y", theme),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoTile(String title, String value, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.bodySmall),
        Text(value, style: theme.textTheme.bodyLarge),
      ],
    );
  }
}
