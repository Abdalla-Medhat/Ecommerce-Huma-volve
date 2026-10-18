import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error_handling/error_handling.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_source/login_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entites/login_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/repository/login_repository.dart';

class RepositoryImp implements LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  RepositoryImp({required this.loginRemoteDataSource});
  @override
  Future<Either<Failure, LoginEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final loginData = await loginRemoteDataSource.login(email, password);
      return Right(loginData as LoginEntity);
    } catch (e) {
      return Left(ErrorHandler.errorHandler(e));
    }
  }
}
