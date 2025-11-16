import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/network/sharedpreferences_service.dart';
import 'package:news_app/features/auth/domain/entities/user_entity.dart';
import 'package:news_app/features/auth/domain/usecase/user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserUsecase userUsecase;
  UserCubit({required this.userUsecase}) : super(UserInitial());

  Future<void> signInWithGoogle() async {
    emit(UserLoading());
    try {
      final user = await userUsecase.signInWithGoogle();
      if (user != null) {
        await SharedPrefUtils.setLoggedIn(true);
        emit(UserLoaded(user: user));
      } else {
        emit(UserError(message: "Sign in failed"));
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(SignOutLoading());
    try {
      await userUsecase.signOut();
      await SharedPrefUtils.setLoggedIn(false);
      emit(SignOutLoaded(message: "Signed out successfully"));
    } catch (e) {
      emit(SignOutError(message: e.toString()));
    }
  }
}
