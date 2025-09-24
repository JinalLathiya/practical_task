import 'package:practical/src/core/base/repository.dart';
import 'package:practical/src/core/network/auth_api_service.dart';
import 'package:practical/src/data/model/auth.dart';
import 'package:practical/src/data/services/local_storage_service.dart';

final class CommonRepository extends BaseRepository {
  CommonRepository({required LocalStorageService localStorageService, required AuthApiService apiService})
    : _localStorageService = localStorageService,
      _apiService = apiService;

  final LocalStorageService _localStorageService;
  final AuthApiService _apiService;

  String? getLanguageCode() {
    return _localStorageService.languageCode;
  }

  void updateLanguageCode(String languageCode) {
    _localStorageService.languageCode = languageCode;
  }

  Future<LoginResponse> login({required String email, required String password}) async {
    final responseData = await _apiService.login(
      request: LoginRequest(
        email: email,
        password: password,
        device_id: '12345',
        device_type: 'android',
        device_token: 'dhsbchsbhsadsaded',
      ),
    );
    return responseData;
  }
}
