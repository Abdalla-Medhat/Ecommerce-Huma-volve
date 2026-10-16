import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error_handling/error_handling.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/details/data/data_source/product_details_remote_data_source.dart.dart';
import 'package:ecommerce_app_huma_volve/features/details/domain/repository/product_details_repository.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsRemoteDataSource remoteDataSource;

  ProductDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, HomeProductEntity>> getProductDetails(
    int productId,
  ) async {
    try {
      final productModel = await remoteDataSource.getProductDetails(productId);
      return Right(productModel);
    } catch (e) {
      return Left(ErrorHandler.errorHandler(e));
    }
  }
}
