import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/details/data/data_source/product_details_remote_data_source.dart.dart';
import 'package:ecommerce_app_huma_volve/features/details/data/repository/product_details_repository_impl.dart';
import 'package:ecommerce_app_huma_volve/features/details/domain/use_cases/get_product_details_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/details/presentation/view/screens/product_details_screen.dart';
import 'package:ecommerce_app_huma_volve/features/details/presentation/view_model/product_details_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/splash/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final appRouting = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: "/products/:id",
      builder: (context, state) {
        final id = state.pathParameters['id'];
        final productId = int.parse(id!);

        return BlocProvider(
          create: (context) {
            final apiClient = ApiClient();

            final remoteDataSource = ProductDetailsRemoteDataSourceImpl(
              apiClient,
            );
            final repository = ProductDetailsRepositoryImpl(remoteDataSource);
            final useCase = GetProductDetailsUseCase(repository);

            return ProductDetailsCubit(useCase)..getProductDetails(productId);
          },
          child: ProductDetailsScreen(productId: productId),
        );
      },
    ),
  ],
);
