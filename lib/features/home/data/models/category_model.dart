import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_entity.dart';

class HomeCategoryModel extends HomeCategoryEntity {
  HomeCategoryModel({super.id, super.name});

  HomeCategoryModel.fromJson(Map<String, dynamic> json)
    : super(id: json['id'] ?? 0, name: json['name'] ?? '');
}
