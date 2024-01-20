import 'package:bloc/bloc.dart';

import 'package:injectable/injectable.dart';
import 'package:pixel_place/domain/repositories/auth_repository.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(AuthInitial());

  bool get isSignedIn => _authRepository.isSigned;

  Future<void> login() async {
    await _authRepository.loginAnonnymously();
    emit(AuthLoggedIn());
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(AuthLoggedOut());
  }
}
