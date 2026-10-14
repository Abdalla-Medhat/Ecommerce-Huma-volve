part of "login_cubit.dart";

sealed class LoginStates {
  const LoginStates();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginError extends LoginStates {
  final String message;
  const LoginError(this.message);
  @override
  List<Object> get props => [message];
}

class LoginSuccess extends LoginStates {
  final LoginEntity loginEntity;
  const LoginSuccess(this.loginEntity);
  @override
  List<Object> get props => [loginEntity];
}
