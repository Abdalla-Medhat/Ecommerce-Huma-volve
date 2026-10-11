import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_res_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/singup_req_model.dart';

class SingupService {
  ApiClient apiClient;
  SingupService(this.apiClient);

  Future<SignupResModel> singUp(SingupReqModel singUpReqModel) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.singUpEndpoint,
      data: {
        "name": singUpReqModel.name,
        "email": singUpReqModel.email,
        "password": singUpReqModel.password,
        "avatar": singUpReqModel.avatar,
      },
    );

    final Map<String, dynamic> data = response.data;
    return SignupResModel.fromJson(data);
  }
}
