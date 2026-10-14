import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entites/login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> login(String email, String password);
}
