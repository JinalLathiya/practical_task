import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:practical/src/core/base/base_bloc.dart';
import 'package:practical/src/core/base/loading_handler.dart';
import 'package:practical/src/core/extensions/extensions.dart';
import 'package:practical/src/data/repository/comman_repository.dart';
import 'package:practical/src/localization/generated/l10n.dart';
import 'package:practical/src/presentation/resources/assets.dart';
import 'package:practical/src/presentation/resources/size_constants.dart';
import 'package:practical/src/presentation/resources/svg_icon.dart';

part 'login_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider(
      create: (context) => LoginBloc(
        commonRepository: RepositoryProvider.of(context),
        loadingHandler: LoadingDialogHandler(context: context),
      ),
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) => current is LoginSuccessState,
        listener: (context, state) {
          Navigator.of(context).pushNamed('/home');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                l10n.loginSuccessMessage,
                style: context.theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: LoginViewBuilder(),
      ),
    );
  }
}

class LoginViewBuilder extends StatefulWidget {
  const LoginViewBuilder({super.key});

  @override
  State<LoginViewBuilder> createState() => _LoginViewBuilder();
}

class _LoginViewBuilder extends State<LoginViewBuilder> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.directional(bottom: Spacing.large),
        child: Column(
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

            //Login Form
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.normal),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(l10n.loginScreenTitle, style: theme.textTheme.headlineMedium),
                    Gap(Spacing.normal),
                    Text(
                      l10n.loginScreenContent,
                      style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                    Gap(Spacing.xLarge),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      validator: (value) => validateEmail(value, context),
                      decoration: InputDecoration(
                        hintText: l10n.emailHintText,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(Spacing.medium),
                          child: SvgIcon(SvgIcons.emailIcon, size: 18),
                        ),
                      ),
                    ),
                    Gap(Spacing.large),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      obscuringCharacter: '●',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => validatePassword(value, context),
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: l10n.passwordHintText,
                        suffixIcon: IconButton(
                          iconSize: 24,
                          onPressed: () {
                            _isPasswordVisible = !_isPasswordVisible;
                            setState(() {});
                          },
                          icon: SvgIcon(_isPasswordVisible ? SvgIcons.eyeIcon : SvgIcons.slashEyeIcon),
                        ),
                      ),
                    ),
                    Gap(Spacing.xxxLarge),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(
                      OnLoginRequested(email: _emailController.text.trim(), password: _passwordController.text.trim()),
                    );
                  }
                },
                child: Text(l10n.signInButtonLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Validation of Fields
String? validatePassword(String? value, BuildContext context) {
  if (value == null) {
    return null;
  } else if (value.isEmpty) {
    return AppLocalizations.of(context).requiredPasswordError;
  } else if (value.length < 8) {
    return AppLocalizations.of(context).passwordLengthError;
  } else {
    return null;
  }
}

String? validateEmail(String? value, BuildContext context) {
  const kEmailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  if (value == null) {
    return null;
  } else if (value.isEmpty) {
    return AppLocalizations.of(context).requiredEmailError;
  } else if (!RegExp(kEmailPattern).hasMatch(value)) {
    return AppLocalizations.of(context).invalidEmailError;
  } else {
    return null;
  }
}
