import 'package:ecommerce_app_huma_volve/features/profile/data/data_source/localFavoriteDataImp.dart';
import 'package:ecommerce_app_huma_volve/features/profile/data/view_model/favorite_modle.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  LocalFavoriteDataImp localFavoriteDataImp = LocalFavoriteDataImp();

  Future getFavoritesItems() async {
    emit(FavoriteLoading());
    try {
      List<FavoriteItem> faveItems = await localFavoriteDataImp
          .getLocalFavoritesData();
      if (faveItems.isEmpty) {
        emit(FavoriteEmpty());
      } else {
        emit(FavoriteSuccess(faveItems));
      }
    } catch (e) {
      emit(FavoriteError(e.toString()));
      debugPrint("Something went wrong ====> $e");
    }
  }

  Future<void> deletAll() async {
    await localFavoriteDataImp.deleteAll();
  }

  Future<void> deleteItem(int faveId) async {
    localFavoriteDataImp.deleteItem(faveId).then((_) => getFavoritesItems());
  }
}
