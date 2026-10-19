import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<HomeProductModel> getProductDetails(int productId);
}

class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSource {
  final ApiClient apiClient;

  ProductDetailsRemoteDataSourceImpl(this.apiClient);

  @override
  Future<HomeProductModel> getProductDetails(int productId) async {
    final response = await apiClient.dio.get(
      '${ApiEndpoints.productsEndpoint}/$productId',
    );
    return HomeProductModel.fromJson(response.data);
  }
}
