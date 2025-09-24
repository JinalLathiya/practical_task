import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:practical/src/core/network/auth_api_service.dart';
import 'package:practical/src/data/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class DataDependency {
  @preResolve
  @lazySingleton
  Future<LocalStorageService> providesLocalStorageService() async {
    SharedPreferencesWithCache preferences = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
    return LocalStorageService(preferences);
  }

  @lazySingleton
  Dio providesDioClient(LocalStorageService localStorageService) {
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: "https://app.happystories.io/api/V1/",
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1),
      headers: {Headers.acceptHeader: Headers.jsonContentType, Headers.contentTypeHeader: Headers.jsonContentType},
    );

    final dioClient = Dio(baseOptions);

    return dioClient;
  }

  @lazySingleton
  AuthApiService providesAuthApiService(Dio dioClient) {
    return AuthApiService(dioClient);
  }
}
