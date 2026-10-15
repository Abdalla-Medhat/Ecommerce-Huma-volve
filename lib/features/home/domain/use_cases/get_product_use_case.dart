import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';

class GetProductUseCase {
  HomeRepository homeRepository;
  GetProductUseCase(this.homeRepository);

  Future<Either<Failure, List<HomeProductEntity>>> invoke(
    int categoryId, {
    required int limit,
    required int offset,
  }) => homeRepository.getProducts(categoryId, limit: limit, offset: offset);
}
