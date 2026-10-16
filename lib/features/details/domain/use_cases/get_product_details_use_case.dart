import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/details/domain/repository/product_details_repository.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';

class GetProductDetailsUseCase {
  final ProductDetailsRepository repository;

  GetProductDetailsUseCase(this.repository);

  Future<Either<Failure, HomeProductEntity>> invoke(int productId) {
    return repository.getProductDetails(productId);
  }
}
