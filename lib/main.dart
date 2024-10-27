import 'package:flutter/material.dart';
import 'package:practical_task/home_view/home_view.dart';

import 'components/components.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: _textTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
        inputDecorationTheme: _inputDecorationTheme(),
      ),
      home: const HomeView(),
    );
  }

  TextTheme _textTheme() {
    const textTheme = TextTheme(
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 1.5, color: Colors.black),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, height: 1.5, color: Colors.black),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.5, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.5, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 1.5, color: Colors.black),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.5, color: Colors.black),
    );

    return textTheme;
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(RadiusValues.small)),
        padding: const EdgeInsets.symmetric(vertical: Spacing.small, horizontal: Spacing.normal),
      ),
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    final iconColor = WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.error)) return Colors.redAccent;
      if (states.contains(WidgetState.focused)) return Colors.amber;
      return const Color(0xFF6E7B8B);
    });

    final border = MaterialStateOutlineInputBorder.resolveWith((states) {
      const defaultBorder = OutlineInputBorder(
        borderRadius: ShapeBorderRadius.small,
        borderSide: BorderSide(color: Colors.black45),
      );

      if (states.contains(WidgetState.error)) {
        if (states.contains(WidgetState.hovered)) {
          return defaultBorder.copyWith(
            borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
          );
        }
        if (states.contains(WidgetState.focused)) {
          return defaultBorder.copyWith(
            borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
          );
        }
        return defaultBorder.copyWith(
          borderSide: const BorderSide(color: Colors.redAccent),
        );
      }
      if (states.contains(WidgetState.hovered)) {
        return defaultBorder.copyWith(
          borderSide: BorderSide(color: Colors.amber.withOpacity(0.6), width: 2.0),
        );
      }
      if (states.contains(WidgetState.focused)) {
        return defaultBorder.copyWith(
          borderSide: const BorderSide(color: Colors.amber, width: 2.0),
        );
      }
      return defaultBorder;
    });

    return InputDecorationTheme(
      errorMaxLines: 3,
      helperMaxLines: 3,
      hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black38),
      errorStyle: const TextStyle(fontWeight: FontWeight.w500),
      helperStyle: const TextStyle(fontWeight: FontWeight.w500),
      contentPadding: const EdgeInsets.symmetric(horizontal: Spacing.normal, vertical: Spacing.normal),
      border: border,
      filled: false,
      suffixIconColor: iconColor,
      prefixIconColor: iconColor,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );
  }
}
