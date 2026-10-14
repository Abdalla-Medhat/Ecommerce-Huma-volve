import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_entity.dart';

class HomeProductModel extends HomeProductEntity {
  HomeProductModel({
    super.id,
    super.title,
    super.slug,
    super.price,
    super.description,
    super.category,
    super.images,
  });

  HomeProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    title = json['title'] ?? '';
    slug = json['slug'] ?? '';
    price = json['price'] ?? 0;
    description = json['description'] ?? '';
    category = json['category'] != null
        ? HomeCategoryModel.fromJson(json['category'])
        : HomeCategoryEntity();
    images = json['images'] != null ? List<String>.from(json['images']) : [];
  }
}
