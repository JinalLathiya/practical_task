import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoadingDialogHandler extends LoadingHandler {
  LoadingDialogHandler({required BuildContext context}) : _context = context;

  final BuildContext _context;
  Route<void>? _dialogRoute;

  Widget _buildDialog(BuildContext context) {
    return PopScope(canPop: false, child: Center(child: CircularProgressIndicator()));
  }

  Route<void> _buildDialogRoute() {
    return RawDialogRoute(
      barrierDismissible: false,
      pageBuilder: (buildContext, animation, secondaryAnimation) {
        Widget dialog = SafeArea(child: Builder(builder: _buildDialog));

        return dialog;
      },
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: child,
        );
      },
    );
  }

  @override
  void handleLoading(bool loading) {
    if (loading) {
      if (_dialogRoute != null) return;
      _dialogRoute = _buildDialogRoute();
      Navigator.maybeOf(_context)?.push(_dialogRoute!);
    } else {
      if (_dialogRoute != null) Navigator.maybeOf(_context)?.removeRoute(_dialogRoute!);
      _dialogRoute = null;
    }
  }
}


typedef LoadingHandlerCallback = void Function(bool loading);

abstract mixin class LoadingHandler {
  const LoadingHandler();

  const factory LoadingHandler.fromCallback({required LoadingHandlerCallback handleLoading}) = _LoadingHandler;

  @mustCallSuper
  void startLoading() {
    handleLoading(true);
  }

  @mustCallSuper
  void stopLoading() {
    handleLoading(false);
  }

  void handleLoading(bool loading);
}

class _LoadingHandler extends LoadingHandler {
  const _LoadingHandler({required LoadingHandlerCallback handleLoading}) : _handleLoadingCallback = handleLoading;

  final LoadingHandlerCallback _handleLoadingCallback;

  @override
  void handleLoading(bool loading) {
    _handleLoadingCallback(loading);
  }
}
