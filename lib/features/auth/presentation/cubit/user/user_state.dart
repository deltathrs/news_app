part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final UserEntity user;

  UserLoaded({required this.user});
}

final class UserError extends UserState {
  final String message;

  UserError({required this.message});
}

final class SignOutLoading extends UserState {}

final class SignOutLoaded extends UserState {
  final String message;

  SignOutLoaded({required this.message});
}

final class SignOutError extends UserState {
  final String message;

  SignOutError({required this.message});
}
