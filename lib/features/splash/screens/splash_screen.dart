import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/core/storage/secure_storage.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_source/login_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_source/login_remote_data_source_imp.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/repository/repository_imp.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/repository/login_repository.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/use_cases/login_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/presentation/view_model/login_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/main_navigation/screens/main_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme.dart';
import '../../auth/login/presentation/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final LoginCubit loginCubit;
  late final LoginUseCase loginUseCase;
  late final LoginRepository loginRepository;
  late final LoginRemoteDataSource loginRemoteDataSource;
  late final ApiClient apiClient;
  @override
  void initState() {
    super.initState();
    apiClient = ApiClient();

    loginRemoteDataSource = LoginRemoteDataSourceImp(apiClient);
    loginRepository = RepositoryImp(
      loginRemoteDataSource: loginRemoteDataSource,
    );
    loginUseCase = LoginUseCase(loginRepository);
    loginCubit = LoginCubit(loginUseCase);

    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));

    final accessToken = await SecureStorage.getAccessToken();
    final refreshToken = await SecureStorage.getRefreshToken();

    if (mounted) {
      if ((accessToken != null && accessToken.isNotEmpty) &&
          (refreshToken != null && refreshToken.isNotEmpty)) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MainNavigationScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                BlocProvider(
                  create: (context) => loginCubit,
                  child: const LoginScreen(),
                ),

            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, size: 120, color: AppTheme.primary),
            const SizedBox(height: 24),
            Text(
              'Huma-volve',
              style: Theme.of(context).textTheme.displayLarge
                  ?.copyWith(fontSize: 40, color: AppTheme.primary),
            ),
            const SizedBox(height: 8),
            Text(
              'Your Ultimate E-Commerce App',
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 48),
            CircularProgressIndicator(color: AppTheme.primary),
          ],
        ),
      ),
    );
  }
}
