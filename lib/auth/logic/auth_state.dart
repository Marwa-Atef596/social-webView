part of 'auth_cubit.dart';

enum AppStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AppStatus status;
  final String? userName;
  final String? userEmail;
  final String? errorMessage;

  AuthState({
    required this.status,
    this.userName,
    this.userEmail,
    this.errorMessage,
  });

  factory AuthState.initial() {
    return AuthState(status: AppStatus.initial);
  }

  AuthState copyWith({
    AppStatus? status,
    String? userName,
    String? userEmail,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
