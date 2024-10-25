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
}
