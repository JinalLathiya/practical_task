import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:practical_task/components/size.dart';

void showGeneralMessage({required BuildContext context, required String content}) {
  final alertMessage = AlertMessage(
    content: content,
    leading: const Icon(Icons.info_outline_rounded),
  );
  showAlertMessage(context, alertMessage);
}

void showSuccessMessage({required BuildContext context, required String content}) {
  final alertMessage = AlertMessage(
    content: content,
    leading: const Icon(Icons.check_circle_outline_rounded),
    style: AlertMessageStyle.success,
  );
  showAlertMessage(context, alertMessage);
}

void showErrorMessage({required BuildContext context, required String content}) {
  final alertMessage = AlertMessage(
    content: content,
    leading: const Icon(Icons.error_outline_rounded),
    style: AlertMessageStyle.error,
  );
  showAlertMessage(context, alertMessage);
}

void showAlertMessage(BuildContext context, AlertMessage alertMessage) {
  OverlayState? overlayState = Navigator.of(context, rootNavigator: true).overlay;
  if (overlayState == null) return;

  OverlayEntry? overlayEntry;

  final Widget overlay = Directionality(
    textDirection: Directionality.of(context),
    child: Builder(
      builder: (context) {
        final mediaQuery = MediaQuery.of(context);
        return Positioned.fill(
          top: math.max(mediaQuery.padding.top + 8, Spacing.normal),
          left: math.max(mediaQuery.padding.left, Spacing.normal),
          right: math.max(mediaQuery.padding.right, Spacing.normal),
          bottom: math.max(mediaQuery.padding.bottom, mediaQuery.viewInsets.bottom) + 8,
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: 1.0,
            child: _AlertMessageView(
              content: alertMessage.content,
              leading: alertMessage.leading,
              style: alertMessage.style,
              duration: const Duration(seconds: 5),
              onRemoved: () => overlayEntry?.remove(),
            ),
          ),
        );
      },
    ),
  );

  overlayEntry = OverlayEntry(builder: (context) => overlay);
  overlayState.insert(overlayEntry);
}

enum AlertMessageStyle {
  general,
  success,
  error,
}

class AlertMessage {
  const AlertMessage({
    required this.content,
    this.leading,
    this.style = AlertMessageStyle.general,
  });

  final String content;
  final Widget? leading;
  final AlertMessageStyle style;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlertMessage &&
          runtimeType == other.runtimeType &&
          content == other.content &&
          leading == other.leading &&
          style == other.style;

  @override
  int get hashCode => content.hashCode ^ leading.hashCode ^ style.hashCode ^ style.hashCode;
}

class _AlertMessageView extends StatefulWidget {
  const _AlertMessageView({
    required this.content,
    required this.leading,
    this.style = AlertMessageStyle.general,
    required this.duration,
    required this.onRemoved,
  });

  final String content;
  final Widget? leading;
  final AlertMessageStyle style;
  final Duration duration;
  final VoidCallback onRemoved;

  @override
  State<_AlertMessageView> createState() => _AlertMessageViewState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('content', content));
    properties.add(DiagnosticsProperty<Widget?>('leading', leading));
    properties.add(EnumProperty<AlertMessageStyle>('style', style));
    properties.add(DiagnosticsProperty<Duration>('duration', duration));
    properties.add(ObjectFlagProperty<VoidCallback>.has('onRemoved', onRemoved));
  }
}

class _AlertMessageViewState extends State<_AlertMessageView> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  final GlobalKey _dismissibleKey = GlobalKey();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      vsync: this,
    );
    final parentAnimation = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _fadeAnimation = Tween(begin: 0.5, end: 1.0).animate(parentAnimation);
    _slideAnimation = Tween(begin: const Offset(0, -1), end: Offset.zero).animate(parentAnimation);

    _timer = Timer(widget.duration, _dismiss);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _dismiss() {
    _controller.reverse().whenComplete(_onDismissed);
  }

  void _onDismissed() {
    _controller.reverse();
    widget.onRemoved();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final AlertMessageThemeData? alertMessageTheme = AlertMessageTheme.maybeOf(context);
    final AlertMessageThemeData defaults = _AlertMessageThemeDataDefaults(context);

    Color effectiveBackgroundColor;
    Color effectiveForegroundColor;
    Color effectiveOutlineColor;

    switch (widget.style) {
      case AlertMessageStyle.general:
        effectiveBackgroundColor = alertMessageTheme?.backgroundColor ?? defaults.backgroundColor!;
        effectiveForegroundColor = alertMessageTheme?.foregroundColor ?? defaults.foregroundColor!;
        effectiveOutlineColor = alertMessageTheme?.outlineColor ?? defaults.outlineColor!;
      case AlertMessageStyle.success:
        effectiveBackgroundColor =
            Color.alphaBlend(const Color(0xFF32BC32).withOpacity(0.1), colorScheme.surfaceContainerLow);
        effectiveForegroundColor = const Color(0xFF32BC32);
        effectiveOutlineColor = const Color(0xFF32BC32);
      case AlertMessageStyle.error:
        effectiveBackgroundColor =
            Color.alphaBlend(const Color(0xFFFF3A30).withOpacity(0.1), colorScheme.surfaceContainerLow);
        effectiveForegroundColor = const Color(0xFFFF3A30);
        effectiveOutlineColor = const Color(0xFFFF3A30);
    }

    final contentTextStyle = DefaultTextStyle.of(context)
        .style
        .merge(alertMessageTheme?.contentTextStyle ?? defaults.contentTextStyle!)
        .copyWith(color: effectiveForegroundColor);

    Widget child = Text(
      widget.content,
      textAlign: TextAlign.start,
      maxLines: 6,
      overflow: TextOverflow.ellipsis,
    );

    if (widget.leading != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconTheme(
            data: IconThemeData(color: effectiveForegroundColor),
            child: widget.leading!,
          ),
          const Gap(Spacing.small),
          Flexible(child: child),
        ],
      );
    }

    child = Material(
      color: effectiveBackgroundColor.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: ShapeBorderRadius.small,
        side: BorderSide(color: effectiveOutlineColor),
      ),
      clipBehavior: Clip.antiAlias,
      textStyle: contentTextStyle,
      child: Container(
        constraints: const BoxConstraints(minHeight: 32, maxWidth: 560),
        padding: const EdgeInsets.symmetric(horizontal: Spacing.normal, vertical: Spacing.medium),
        child: child,
      ),
    );

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Semantics(
          container: true,
          liveRegion: true,
          onDismiss: _onDismissed,
          child: Dismissible(
            key: _dismissibleKey,
            direction: DismissDirection.up,
            onDismissed: (direction) => _onDismissed(),
            child: child,
          ),
        ),
      ),
    );
  }
}

class AlertMessageTheme extends InheritedTheme {
  const AlertMessageTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final AlertMessageThemeData data;

  static AlertMessageThemeData of(BuildContext context) {
    return maybeOf(context) ?? const AlertMessageThemeData();
  }

  static AlertMessageThemeData? maybeOf(BuildContext context) {
    AlertMessageTheme? stepperTheme = context.dependOnInheritedWidgetOfExactType<AlertMessageTheme>();
    return stepperTheme?.data ?? Theme.of(context).extension<AlertMessageThemeData>();
  }

  @override
  bool updateShouldNotify(AlertMessageTheme oldWidget) => data != oldWidget.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return AlertMessageTheme(data: data, child: child);
  }
}

class AlertMessageThemeData extends ThemeExtension<AlertMessageThemeData> with Diagnosticable {
  const AlertMessageThemeData({
    this.backgroundColor,
    this.foregroundColor,
    this.outlineColor,
    this.contentTextStyle,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? outlineColor;
  final TextStyle? contentTextStyle;

  @override
  AlertMessageThemeData copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? outlineColor,
    TextStyle? contentTextStyle,
  }) {
    return AlertMessageThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      outlineColor: outlineColor ?? this.outlineColor,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
    );
  }

  @override
  ThemeExtension<AlertMessageThemeData> lerp(covariant ThemeExtension<AlertMessageThemeData>? other, double t) {
    if (other is! AlertMessageThemeData) return this;
    return copyWith(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t),
      outlineColor: Color.lerp(outlineColor, other.outlineColor, t),
      contentTextStyle: TextStyle.lerp(contentTextStyle, other.contentTextStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(ColorProperty('foregroundColor', foregroundColor));
    properties.add(ColorProperty('outlineColor', outlineColor));
    properties.add(DiagnosticsProperty<TextStyle?>('contentTextStyle', contentTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlertMessageThemeData &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          foregroundColor == other.foregroundColor &&
          outlineColor == other.outlineColor &&
          contentTextStyle == other.contentTextStyle;

  @override
  int get hashCode => Object.hashAll([backgroundColor, foregroundColor, outlineColor, contentTextStyle]);
}

class _AlertMessageThemeDataDefaults extends AlertMessageThemeData {
  _AlertMessageThemeDataDefaults(this.context);

  final BuildContext context;
  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colors = _theme.colorScheme;
  late final TextTheme _textTheme = _theme.textTheme;

  @override
  Color? get backgroundColor => _colors.inversePrimary;

  @override
  Color? get foregroundColor => _colors.primary;

  @override
  Color? get outlineColor => _colors.primary;

  @override
  TextStyle? get contentTextStyle => _textTheme.bodyMedium;
}
