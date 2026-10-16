import 'package:ecommerce_app_huma_volve/features/details/domain/use_cases/get_product_details_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  ProductDetailsCubit(this.getProductDetailsUseCase) : super(ProductDetailsInitial());

  Future<void> getProductDetails(int productId) async {
    emit(ProductDetailsLoading());

    final result = await getProductDetailsUseCase.invoke(productId);

    result.fold(
      (failure) => emit(ProductDetailsError(failure.failureMessage)),
      (product) => emit(ProductDetailsSuccess(product)),
    );
  }
}