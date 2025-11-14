// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class FirebaseAuthDatasource {
//   final FirebaseAuth auth;
//   final GoogleSignIn googleSignIn;

//   FirebaseAuthDatasource({required this.auth, required this.googleSignIn});
  
//   Future<UserCredential> signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//     if (googleUser == null) {
//       throw Exception('Google sign-in aborted');
//     }

//     final GoogleSignInAuthentication googleAuth =
//         await googleUser.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     return await auth.signInWithCredential(credential);
//   }
// }
