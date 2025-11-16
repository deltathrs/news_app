import 'package:news_app/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:news_app/features/auth/domain/entities/user_entity.dart';
import 'package:news_app/features/auth/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuthDatasource firebaseAuthDatasource;

  UserRepositoryImpl({required this.firebaseAuthDatasource});

  @override
  Future<UserEntity?> signInWithGoogle() {
    return firebaseAuthDatasource.signInWithGoogle();
  }

  @override
  Future<void> signOut() {
    return firebaseAuthDatasource.signOut();
  }
}
