part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class CategoriesLoading extends HomeState {}

class CategoriesSuccess extends HomeState {
  final List<CategoryModel> categories;
  const CategoriesSuccess(this.categories);
  @override
  List<Object> get props => [categories];
}

class CategoriesError extends HomeState {
  final String message;
  const CategoriesError(this.message);
  @override
  List<Object> get props => [message];
}

class ProductsLoading extends HomeState {}

class ProductsSuccess extends HomeState {
  final List<ProductModel> products;
  const ProductsSuccess(this.products);
  @override
  List<Object> get props => [products];
}

class ProductsError extends HomeState {
  final String message;
  const ProductsError(this.message);
  @override
  List<Object> get props => [message];
}
