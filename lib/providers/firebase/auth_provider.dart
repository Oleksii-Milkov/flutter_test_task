import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test_task/providers/user_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  User? get currentUser => firebaseAuth.currentUser;

  Future<void> signInWithGoogle() async {
    final googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final googleSignInAuth = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );

      try {
        await firebaseAuth.signInWithCredential(credential);
        if (currentUser != null) userProvider.setUserInfo(currentUser!);
      } on FirebaseAuthException catch (err) {
        switch (err.code) {
          case 'account-exists-with-different-credential':
          case 'invalid-credential':
            if (kDebugMode) print(err);
        }
      } catch (err) {
        if (kDebugMode) print(err);
      }
    }
  }

  Future<void> signOut() async {
    googleSignIn.disconnect();
    await firebaseAuth.signOut();
  }
}

AuthProvider authProvider = AuthProvider();
