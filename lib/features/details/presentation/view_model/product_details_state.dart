part of 'product_details_cubit.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsSuccess extends ProductDetailsState {
  final HomeProductEntity product;
  final bool isFavorite;

  const ProductDetailsSuccess(this.product, {required this.isFavorite});

  ProductDetailsSuccess copyWith({
    HomeProductEntity? product,
    bool? isFavorite,
  }) {
    return ProductDetailsSuccess(
      product ?? this.product,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object> get props => [product, isFavorite];
}

class ProductDetailsError extends ProductDetailsState {
  final String message;

  const ProductDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
