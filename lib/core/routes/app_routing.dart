import 'package:ecommerce_app_huma_volve/features/details/presentation/view/screens/product_details_screen.dart';
import 'package:ecommerce_app_huma_volve/features/splash/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final appRouting = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: "/products/:id",
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return ProductDetailsScreen(productId: int.parse(id!));
      },
    ),
  ],
);
