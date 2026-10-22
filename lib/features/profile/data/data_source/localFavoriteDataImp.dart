import 'dart:convert';

import 'package:ecommerce_app_huma_volve/features/profile/data/view_model/favorite_modle.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalFavoriteDataImp {
  static Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();

  Future<List<FavoriteItem>> getLocalFavoritesData() {
    return prefs.then((v) {
      String? data = v.getString('favorites');
      List<dynamic> decodedFavorites = data != null ? jsonDecode(data) : [];
      debugPrint("===============>>> $decodedFavorites");
      List<FavoriteItem> faveModel = decodedFavorites
          .map((e) => FavoriteItem.fromJson(e))
          .toList();
      return faveModel;
    });
  }

  Future<void> deleteAll() async {
    await prefs.then((v) => v.clear());
  }

  Future<void> deleteItem(int productId) async {
    await prefs.then((v) async {
      String data = v.getString('favorites')!;
      List<dynamic> decodedFavorites = jsonDecode(data);
      decodedFavorites.removeWhere((element) => element['id'] == productId);

      await v.setString('favorites', jsonEncode(decodedFavorites));
    });
  }
}
