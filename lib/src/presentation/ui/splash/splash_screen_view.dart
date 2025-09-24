import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practical/src/core/extensions/extensions.dart';
import 'package:practical/src/presentation/resources/assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => Navigator.of(context).pushNamed('/language-selection'));
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.splashImage),
                fit: BoxFit.cover,
                alignment: Alignment.center,
                colorFilter: ColorFilter.mode(theme.colorScheme.primary.withOpacity(0.5), BlendMode.color),
              ),
            ),
          ),
          Center(child: Image.asset(AppImages.appLogo, fit: BoxFit.cover)),
        ],
      ),
    );
  }
}
