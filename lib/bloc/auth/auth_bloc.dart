import 'package:appbendaharaybi/services/auth_api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApiClient authApiClient = AuthApiClient();
  late SharedPreferences sharedPreferences;
  Future<void> initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  AuthBloc() : super(AuthLogout()) {
    initSharedPreferences();
    on<AuthEventLogin>((event, emit) async {
      try {
        emit(AuthLoading());
        final token = await authApiClient.login(event.email, event.pass);
        _saveToken(token);
        emit(AuthLogin());
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });
  }

  Future<void> _saveToken(String token) async {
    await sharedPreferences.setString('token', token);
  }

  String? getToken() {
    return sharedPreferences.getString('token');
  }
}
