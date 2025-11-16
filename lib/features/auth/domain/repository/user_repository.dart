import 'package:news_app/features/auth/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> signInWithGoogle();
  Future<void> signOut();
}
