import 'package:auth_app/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;
  SignUpCubit(this._authRepository) : super(SignUpState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignUpStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignUpStatus.initial));
  }

  Future<void> signUpFormSubmitted() async {
    if (state.status == SignUpStatus.submitting) return;
    emit(state.copyWith(status: SignUpStatus.submitting));
    try {
      await _authRepository.signup(
          email: state.email, password: state.password);
      emit(state.copyWith(status: SignUpStatus.success));
    } catch (_) {}
  }
}
