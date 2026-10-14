import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/storage/secure_storage.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/model/login_model.dart';

class LoginService {
  ApiClient apiClient;
  LoginService(this.apiClient);

  Future<LoginModel> login(String email, String password) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.loginEndpoint,
      data: {'email': email, 'password': password},
    );

    final Map<String, dynamic> data = response.data;

    final modelData = LoginModel.fromJson(data);

    await SecureStorage.saveAccessToken(modelData.accessToken);
    await SecureStorage.saveRefreshAccessToken(modelData.refreshToken);

    return modelData;
  }
}
