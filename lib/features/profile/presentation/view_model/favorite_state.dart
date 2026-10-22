part of 'favorite_cubit.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  final List<FavoriteItem> faveItem;
  @override
  List<Object> get props => [faveItem];
  const FavoriteSuccess(this.faveItem);
}

class FavoriteError extends FavoriteState {
  final String message;
  const FavoriteError(this.message);
}

class FavoriteLoading extends FavoriteState {}

class FavoriteEmpty extends FavoriteState {}
