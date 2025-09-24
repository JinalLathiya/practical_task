import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practical/src/core/base/exceptions.dart';
import 'package:practical/src/core/base/loading_handler.dart';
import 'package:retry/retry.dart';

typedef RequestCallback<T> = FutureOr<T> Function();

abstract mixin class RequestHandler implements ErrorHandler {
  @protected
  Future<T?> processRequest<T>(
    RequestCallback<T> request, {
    LoadingHandler? loadingHandler,
    ErrorHandler? errorHandler,
    bool useDefaultErrorHandler = true,
  }) async {
    T? result;
    try {
      loadingHandler?.startLoading();
      // Retry when token expired and refresh token called
      result = await retry(
        request,
        delayFactor: Durations.short2,
        maxAttempts: 3,
        retryIf: (exception) => exception is SessionExpiredException || exception is NetworkConnectionException,
        maxDelay: Durations.medium2,
      );
    } catch (error, stackTrace) {
      if (errorHandler != null) {
        if (error is InvalidSessionException) handleError(error);
        errorHandler.handleError(error, stackTrace);
      } else if (useDefaultErrorHandler) {
        handleError(error, stackTrace);
      } else {
        rethrow;
      }
    } finally {
      loadingHandler?.stopLoading();
    }
    return result;
  }

  @protected
  Future<T?> processRequestWithRetry<T>(
    RequestCallback<T> request, {
    LoadingHandler? loadingHandler,
    ErrorHandler? errorHandler,
    bool useDefaultErrorHandler = true,
  }) async {
    return processRequest(
      () => retry(
        request,
        delayFactor: const Duration(milliseconds: 100),
        maxAttempts: 3,
        maxDelay: const Duration(milliseconds: 500),
      ),
      loadingHandler: loadingHandler,
      errorHandler: errorHandler,
      useDefaultErrorHandler: useDefaultErrorHandler,
    );
  }
}

typedef ErrorCallback = void Function(Object error, [StackTrace? stackTrace]);

abstract mixin class ErrorHandler {
  const ErrorHandler();

  const factory ErrorHandler.fromCallback({required ErrorCallback handleError}) = _ErrorHandler;

  void handleError(Object error, [StackTrace? stackTrace]);
}

class _ErrorHandler extends ErrorHandler {
  const _ErrorHandler({required ErrorCallback handleError}) : _handleErrorCallback = handleError;

  final ErrorCallback _handleErrorCallback;

  @override
  void handleError(Object error, [StackTrace? stackTrace]) {
    _handleErrorCallback.call(error, stackTrace);
  }
}