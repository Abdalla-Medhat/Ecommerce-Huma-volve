import 'dart:convert';

import 'package:ecommerce_app_huma_volve/features/details/domain/use_cases/get_product_details_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;
  ProductDetailsCubit(this.getProductDetailsUseCase)
    : super(ProductDetailsInitial());

  //intialize shared preferences
  Future<SharedPreferences> initPrefs() async {
    return await SharedPreferences.getInstance();
  }

  //temporary--------------------------
  //delete all shared preferences
  Future deleteAll() async {
    final prefs = await initPrefs();
    await prefs.clear();
  }

  //check if product is favorite
  Future<bool> isFavorite(HomeProductEntity product) async {
    final prefs = await initPrefs();
    final favorites = prefs.getString('favorites');
    List decodedFavorites = favorites != null ? jsonDecode(favorites) : [];

    var dedicatedItem = decodedFavorites.firstWhere(
      (decodedFavorites) => decodedFavorites['id'] == product.id,
      orElse: () => null,
    );
    if (dedicatedItem != null && dedicatedItem['favorite'] == true) {
      emit(ProductDetailsSuccess(product, isFavorite: true));

      return true;
    } else {
      emit(ProductDetailsSuccess(product, isFavorite: false));

      return false;
    }
  }

  //save favorite product
  Future<void> saveFavoriteProduct(HomeProductEntity product) async {
    print("========>saveFavoriteProduct Called");
    final prefs = await initPrefs();
    final favorites = prefs.getString('favorites');
    List<dynamic> decodedFavorites = favorites != null
        ? jsonDecode(favorites)
        : [];
    var dedicatedItem = decodedFavorites.firstWhere(
      (item) => item['id'] == product.id,
      orElse: () => null,
    );

    if (dedicatedItem != null) {
      dedicatedItem['favorite'] = true;
    } else {
      decodedFavorites.add({
        'id': product.id,
        'favorite': true,
        'title': product.title,
        'price': product.price,
        'subtitle': product.slug,
        'imageUrl': product.images[0],
      });
    }
    await prefs.setString('favorites', jsonEncode(decodedFavorites));
    emit(ProductDetailsSuccess(product, isFavorite: true));
  }

  //delete favorite product
  Future<void> deleteFavoriteProduct(HomeProductEntity product) async {
    final prefs = await initPrefs();
    final favorites = prefs.getString('favorites');
    if (favorites == null) return;
    List<dynamic> decodedFavorites = jsonDecode(favorites);

    decodedFavorites.removeWhere((item) => item['id'] == product.id);

    await prefs.setString('favorites', jsonEncode(decodedFavorites));
    emit(ProductDetailsSuccess(product, isFavorite: false));
  }

  Future<void> getProductDetails(int productId) async {
    emit(ProductDetailsLoading());

    final result = await getProductDetailsUseCase.invoke(productId);

    result.fold(
      (failure) => emit(ProductDetailsError(failure.failureMessage)),
      (product) async {
        await isFavorite(product);
      },
    );
  }
}
