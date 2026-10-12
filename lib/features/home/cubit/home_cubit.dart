import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/home_service.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService homeService;

  int? selectedCategoryId;

  HomeCubit(this.homeService) : super(HomeInitial());

  void loadHomeData() async {
    emit(CategoriesLoading());
    try {
      final List<CategoryModel> categories = await homeService.getCategories();
      emit(CategoriesSuccess(categories));

      if (categories.isNotEmpty) {
        selectedCategoryId = categories[0].id;
        await getProductsByCategory(selectedCategoryId);
      }
    } on DioException catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  Future<void> getProductsByCategory(int? categoryId) async {
    emit(ProductsLoading());
    try {
      final List<ProductModel> products = await homeService.getProducts(
        categoryId!,
      );
      emit(ProductsSuccess(products));
    } on DioException catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
