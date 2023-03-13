import 'dart:async';

import 'package:auth_app/models/user_model.dart';
import 'package:auth_app/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

  class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  StreamSubscription<User>? _userSubscription;
  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(authRepository.currentUser.isNotEmpty
            ? AppState.authenticated(authRepository.currentUser)
            : const AppState.unauthenticated()) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequest>(_onLogoutRequested);
    _userSubscription = _authRepository.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }
  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(event.user.isNotEmpty
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated());
  }

  void _onLogoutRequested(AppLogoutRequest event, Emitter<AppState> emit) {
    unawaited(_authRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
