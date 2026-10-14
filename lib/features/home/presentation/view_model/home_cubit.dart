import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/get_product_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductUseCase getProductsByCategoryUseCase;

  int? selectedcategoryId;

  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsByCategoryUseCase,
  }) : super(HomeInitial());

  void loadHomeData() async {
    int categoryId = 0;
    emit(CategoriesLoading());
    final categories = await getCategoriesUseCase.invoke();
    categories.fold(
      (failure) {
        emit(CategoriesError(failure.failureMessage));
      },
      (categories) {
        categoryId = categories[0].id;
        emit(CategoriesSuccess(categories));
      },
    );
    final products = await getProductsByCategoryUseCase.invoke(categoryId);
    products.fold(
      (failure) {
        emit(ProductsError(failure.failureMessage));
      },
      (products) {
        emit(ProductsSuccess(products));
      },
    );
    await getProductsByCategory(categoryId);
  }

  Future<void> getProductsByCategory(int? categoryId) async {
    emit(ProductsLoading());

    final products = await getProductsByCategoryUseCase.invoke(categoryId!);
    products.fold(
      (failure) {
        emit(ProductsError(failure.failureMessage));
      },
      (products) {
        emit(ProductsSuccess(products));
      },
    );
  }
}
