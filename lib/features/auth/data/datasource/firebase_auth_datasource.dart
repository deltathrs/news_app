import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/features/auth/data/model/user_model.dart';

abstract class FirebaseAuthDatasource {
  Future<UserModel?> signInWithGoogle();
  Future<void> signOut();
}

class FirebaseAuthDatasourceImpl implements FirebaseAuthDatasource {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  FirebaseAuthDatasourceImpl({required this.auth, required this.googleSignIn});

  @override
  Future<UserModel?> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await auth.signInWithCredential(credential);

    final user = userCredential.user;
    if (user == null) return null;

    return UserModel.fromFirebase(user);
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }
}
