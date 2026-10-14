import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entites/login_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/use_cases/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginUseCase loginUseCase;
  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> loadData(String email, String password) async {
    emit(LoginLoading());
    final data = await loginUseCase.invoke(email, password);
    data.fold(
      (failure) {
        emit(LoginError(failure.failureMessage));
      },
      (data) {
        emit(LoginSuccess(data));
      },
    );
  }
}
