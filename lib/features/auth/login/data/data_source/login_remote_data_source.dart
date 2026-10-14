import 'package:ecommerce_app_huma_volve/features/auth/login/data/model/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginModel> login(String email, String password);
}
