part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}

class AuthLogin extends AuthState {

}
class AuthLogout extends AuthState {}
class AuthError extends AuthState {
  final String error;

  AuthError({required this.error});
}
