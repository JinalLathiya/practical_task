import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:practical/src/data/model/auth.dart';
import 'package:practical/src/presentation/resources/log.dart';

class AuthApiService {
  AuthApiService(this._dioClient);

  final Dio _dioClient;

  FutureOr<T> _parseResponseData<T>(Response<dynamic> response, T Function(dynamic responseData) parser) {
    return compute((message) {
      try {
        Log.success("parse response => $message");
        return parser(message);
      } catch (error, stackTrace) {
        Log.error(error);
        Log.error(stackTrace);
      }
      return parser(message);
    }, response.data);
  }

  Future<LoginResponse> login({required LoginRequest request}) async {
    Log.debug("Base Url => ${_dioClient.options.baseUrl} - ${_dioClient.options.headers}");
    Log.debug("Request => ${request.toJson()}");
    final response = await _dioClient.post<dynamic>("login", data: request.toJson());
    return _parseResponseData(response, (responseData) => LoginResponse.fromJson(responseData as Map<String, dynamic>));
  }
}
