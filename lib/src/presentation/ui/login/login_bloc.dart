part of 'login_view.dart';

///Note : Currently we have only one API call, so don't need to create individual file.

final class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc({required CommonRepository commonRepository, required LoadingHandler loadingHandler})
    : _commonRepository = commonRepository,
      _loadingHandler = loadingHandler,
      super(const InitialLoginState()) {
    on<OnLoginRequested>(_onLoginRequested);
  }

  final CommonRepository _commonRepository;
  final LoadingHandler _loadingHandler;

  Future<void> _onLoginRequested(OnLoginRequested event, Emitter<LoginState> emit) async {
    try {
      final result = await processRequest(
        () => _commonRepository.login(email: event.email, password: event.password),
        loadingHandler: _loadingHandler,
      );
      if (result != null) {
        emit(LoginSuccessState());
      }
    } catch (error, stackTrace) {
      handleError(error, stackTrace);
    }
  }
}

@immutable
class LoginEvent {
  const LoginEvent();
}

class OnLoginRequested extends LoginEvent {
  const OnLoginRequested({required this.email, required this.password});

  final String email;
  final String password;
}

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class InitialLoginState extends LoginState {
  const InitialLoginState();
}

class LoginSuccessState extends LoginState {
  const LoginSuccessState();
}
