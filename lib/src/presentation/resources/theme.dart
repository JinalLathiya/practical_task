import 'package:flutter/material.dart';
import 'package:practical/src/presentation/resources/size_constants.dart';

class AppTheme {
  final BuildContext context;

  AppTheme(this.context);

  static const String defaultFontFamily = 'Raleway';

  static ColorScheme get _colorScheme {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF00B4BF),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF004961),
      onSecondary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xffe5f7f9),
      secondaryContainer: Color(0xFF80CFB0),
      onSecondaryContainer: Color(0xFF002F1D),
      error: Color(0xFFFD4755),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFEA3AA),
      onErrorContainer: Color(0xFF4C1519),
      surface: Color(0xFFFAFCFD),
      onSurface: Color(0xFF111111),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFFCFCFD),
      surfaceContainer: Color(0xFFF2F4F7),
      surfaceContainerHigh: Color(0xFFE1E3E8),
      surfaceContainerHighest: Color(0xFFE1E3E8),
      onSurfaceVariant: Color(0xFF7C7C7C),
      outline: Color(0xFFE0E0E0),
      outlineVariant: Color(0xFFE0E2E6),
      surfaceTint: Colors.transparent,
      shadow: Color(0x1A606062),
    );
  }

  ThemeData get lightTheme => _getTheme(_colorScheme);

  ThemeData _getTheme(ColorScheme colorScheme) {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: colorScheme,
      fontFamily: defaultFontFamily,
      visualDensity: VisualDensity.standard,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      textTheme: _textTheme(colorScheme),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      elevatedButtonTheme: _elevatedButtonTheme(colorScheme),
    );
  }

  TextTheme _textTheme(ColorScheme colorScheme) {
    return const TextTheme(
      displayLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, letterSpacing: -0.25, height: 1.2),
      displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, letterSpacing: 0.0, height: 1.2),
      displaySmall: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: 0.0, height: 1.2),
      headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: 0.0, height: 1.2),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: 0.0, height: 1.2),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 0.0, height: 1.2),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0.0, height: 1.2),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.15, height: 1.2),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, height: 1.2),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1, height: 1.2),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5, height: 1.2),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5, height: 1.2),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.5, height: 1.5),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.5),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, height: 1.5),
    );
  }

  InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
    final border = WidgetStateInputBorder.resolveWith((states) {
      final defaultBorder = OutlineInputBorder(borderRadius: ShapeBorderRadius.medium, borderSide: BorderSide.none);

      if (states.contains(WidgetState.error)) {
        if (states.contains(WidgetState.hovered)) {
          return defaultBorder.copyWith(borderSide: BorderSide(color: colorScheme.error, width: 2));
        }
        if (states.contains(WidgetState.focused)) {
          return defaultBorder.copyWith(borderSide: BorderSide(color: colorScheme.error, width: 2));
        }
        return defaultBorder.copyWith(borderSide: BorderSide(color: colorScheme.error, width: 2));
      }
      if (states.contains(WidgetState.hovered)) {
        return defaultBorder.copyWith(borderSide: BorderSide(color: colorScheme.primaryContainer, width: 2));
      }
      if (states.contains(WidgetState.focused)) {
        return defaultBorder.copyWith(borderSide: BorderSide(color: colorScheme.primary, width: 2));
      }
      return defaultBorder;
    });

    final iconColor = WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.error)) return colorScheme.error;
      if (states.contains(WidgetState.focused)) return colorScheme.primary;
      return colorScheme.onSurfaceVariant;
    });

    final fillColor = WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return colorScheme.onSurface.withValues(alpha: 0.1);
      }
      if (states.contains(WidgetState.error)) {
        return colorScheme.onSurface.withValues(alpha: 0.1);
      }
      if (states.contains(WidgetState.focused)) {
        return colorScheme.primary.withValues(alpha: 0.1);
      }
      return colorScheme.surfaceContainerHighest.withValues(alpha: 0.75);
    });

    return InputDecorationTheme(
      constraints: BoxConstraints(maxWidth: 600),
      contentPadding: const EdgeInsets.all(Spacing.normal),
      hintStyle: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
      border: border,
      errorMaxLines: 1,
      helperMaxLines: 1,
      suffixIconColor: iconColor,
      prefixIconColor: iconColor,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      fillColor: fillColor,
      filled: true,
      errorBorder: border,
    );
  }

  ElevatedButtonThemeData _elevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.onSecondary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        padding: EdgeInsets.all(Spacing.large),
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
