import 'package:news_app/features/auth/domain/entities/user_entity.dart';
import 'package:news_app/features/auth/domain/repository/user_repository.dart';

class UserUsecase {
  final UserRepository repository;

  UserUsecase({required this.repository});

  Future<UserEntity?> signInWithGoogle() {
    return repository.signInWithGoogle();
  }

  Future<void> signOut() {
    return repository.signOut();
  }
}
