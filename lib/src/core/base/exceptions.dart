import 'package:flutter/foundation.dart';

@immutable
sealed class BaseException implements Exception {
  const BaseException();

  @override
  String toString() => '$runtimeType { }';
}

final class NetworkConnectionException extends BaseException {
  const NetworkConnectionException();
}

final class InternalServerException extends BaseException {
  const InternalServerException();
}

final class RequestTimeoutException extends BaseException {
  const RequestTimeoutException();
}

final class SessionExpiredException extends BaseException {
  const SessionExpiredException();
}

final class InvalidSessionException extends BaseException {
  const InvalidSessionException();
}

final class ResponseDecryptionException extends BaseException {
  const ResponseDecryptionException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType { message: $message }';
}

final class InvalidResponseException extends BaseException {
  const InvalidResponseException({required this.message, required this.statusCode, this.errors});

  final String? message;
  final int statusCode;
  final Map<String, dynamic>? errors;

  @override
  String toString() {
    return 'ApiResponseError { message: $message, statusCode: $statusCode, errors: $errors }';
  }
}

final class RequestProcessingException extends BaseException {
  const RequestProcessingException({required this.message});

  final String message;

  @override
  String toString() {
    return 'RequestProcessingException { message: $message }';
  }
}

final class RequestFailedException extends BaseException {
  const RequestFailedException();
}

final class RequestCancelledException extends BaseException {
  const RequestCancelledException();
}
