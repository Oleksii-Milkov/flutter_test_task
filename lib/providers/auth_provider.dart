import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    firebaseAuth = FirebaseAuth.instance;
    googleSignIn = GoogleSignIn();
  }

  late FirebaseAuth firebaseAuth;
  late GoogleSignIn googleSignIn;

  bool get isAuthorized => firebaseAuth.currentUser != null;

  Future<void> signIn() async {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        await firebaseAuth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
  }

  Future<void> signOut() async {
    googleSignIn.disconnect();
    await firebaseAuth.signOut();
  }
}

AuthProvider authProvider = AuthProvider();
