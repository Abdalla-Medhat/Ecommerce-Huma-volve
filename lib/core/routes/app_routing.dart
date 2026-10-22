import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/presentation/view/login_screen.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/screens/sign_up_screen.dart';
import 'package:ecommerce_app_huma_volve/features/cart/screens/cart_screen.dart';
import 'package:ecommerce_app_huma_volve/features/details/data/data_source/product_details_remote_data_source.dart.dart';
import 'package:ecommerce_app_huma_volve/features/details/data/repository/product_details_repository_impl.dart';
import 'package:ecommerce_app_huma_volve/features/details/domain/use_cases/get_product_details_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/details/presentation/view/screens/product_details_screen.dart';
import 'package:ecommerce_app_huma_volve/features/details/presentation/view_model/product_details_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/main_navigation/screens/main_navigation_screen.dart';
import 'package:ecommerce_app_huma_volve/features/profile/presentation/view/favorites.dart';
import 'package:ecommerce_app_huma_volve/features/profile/presentation/view/profile_screen.dart';
import 'package:ecommerce_app_huma_volve/features/profile/presentation/view_model/favorite_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/splash/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final apiClient = ApiClient();
final remoteDataSource = ProductDetailsRemoteDataSourceImpl(apiClient);
final repository = ProductDetailsRepositoryImpl(remoteDataSource);
final useCase = GetProductDetailsUseCase(repository);
final appRouting = GoRouter(
  initialLocation: "/",
  debugLogDiagnostics: true,
  routes: [
    GoRoute(path: "/", builder: (context, state) => const SplashScreen()),

    GoRoute(path: '/signup', builder: (context, state) => const SignUpScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/main',
      builder: (context, state) => const MainNavigationScreen(),
    ),

    GoRoute(
      path: "/products/:id",
      builder: (context, state) {
        final id = state.pathParameters['id'];
        final productId = int.parse(id!);

        return BlocProvider(
          create: (context) {
            return ProductDetailsCubit(useCase)..getProductDetails(productId);
          },
          child: ProductDetailsScreen(productId: productId),
        );
      },
    ),
    GoRoute(path: "/cart", builder: (context, state) => const CartScreen()),
    GoRoute(
      path: "/profile",
      builder: (context, state) => const ProfileScreen(),
    ),

    GoRoute(
      path: "/favorite",
      builder: (context, state) {
        return BlocProvider(
          create: (context) {
            return FavoriteCubit();
          },
          child: FavoritesScreen(),
        );
      },
    ),
  ],
);
