import 'package:auth_app/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository _authRepository;
  SignInCubit(this._authRepository) : super(SignInState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignInStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignInStatus.initial));
  }

  Future<void> loginWithCredentials() async {
    if (state.status == SignInStatus.submitting) return;
    emit(state.copyWith(status: SignInStatus.submitting));
    try {
      await _authRepository.logInWithEmailAndPassword(
          email: state.email, password: state.password);
      emit(state.copyWith(status: SignInStatus.success));
    } catch (_) {}
  }
}
