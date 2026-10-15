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

  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsByCategoryUseCase,
  }) : super(HomeInitial());

  List<HomeProductEntity> _products = [];
  List<HomeProductEntity> get products => _products;
  int categoryId = 0;
  int _offset = 0;
  int _limit = 10;
  bool _isloadingMore = false;
  bool _hasMore = true;
  void loadHomeData() async {
    emit(CategoriesLoading());
    final categories = await getCategoriesUseCase.invoke();
    categories.fold(
      (failure) {
        emit(CategoriesError(failure.failureMessage));
      },
      (categories) {
        categoryId = categories.first.id;
        emit(CategoriesSuccess(categories));
      },
    );

    await getProductsByCategory(categoryId);
  }

  Future<void> getProductsByCategory(int categoryId) async {
    _offset = 0;
    emit(ProductsLoading());
    _hasMore = true;
    final products = await getProductsByCategoryUseCase.invoke(
      categoryId,
      limit: _limit,
      offset: _offset,
    );
    products.fold(
      (failure) {
        emit(ProductsError(failure.failureMessage));
      },
      (products) {
        _products.clear();
        _offset = products.length;
        _products.addAll(products);
        if (_products.length < _limit) {
          _hasMore = false;
        }

        emit(ProductsSuccess(List.from(_products)));
      },
    );
  }

  Future loadMoreProducts() async {
    if (_isloadingMore || !_hasMore) return;

    _isloadingMore = true;
    emit(ProductsLoading());

    final newProducts = await getProductsByCategoryUseCase.invoke(
      categoryId,
      limit: _limit,
      offset: _offset,
    );
    newProducts.fold(
      (failure) {
        emit(ProductsError(failure.failureMessage));
      },
      (newProducts) {
        _products.addAll(newProducts);
        _offset += newProducts.length;
        if (newProducts.length < _limit) {
          _hasMore = false;
        }
        emit(ProductsSuccess(List.from(_products)));
      },
    );
  }
}
