import 'package:blog_app/models/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseRepo {
  // initCheck variable
  static bool _isGoogleInitialized = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user;
  User? get currentUser => _auth.currentUser;

  Future<void> sendUserData({
    required UserDataModel user,
    required String id,
  }) async {
    try {
      await _firestore.collection('users').doc(id).set(user.toMap());
    } catch (e) {
      throw Exception("Profile Create Failed...error: $e");
    }
  }

  Future<UserDataModel> fetchUserData({required String id}) async {
    try {
      final doc = await _firestore.collection('users').doc(id).get();
      if (doc.exists || doc.data() != null) {
        return UserDataModel.fromMap(doc.data()!);
      }
      throw Exception("Data not found...");
    } catch (e) {
      throw Exception("Server error: $e");
    }
  }

  Future<UserCredential> loginByEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      throw Exception("Login failed.. error : $e");
    }
  }

  Future<UserCredential> signUpByEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final String id = userCredential.user!.uid;
      await sendUserData(
        id: id,
        user: UserDataModel(name: name, email: email),
      );
      return userCredential;
    } catch (e) {
      throw Exception("Register failed.. error : $e");
    }
  }

  // logout
  Future<void> logout() async {
    try {
      await GoogleSignIn.instance.disconnect();
      await GoogleSignIn.instance.signOut();
      await _auth.signOut();
    } catch (e) {
      throw Exception("failed to Logout, Error: $e");
    }
  }

  //delete account

  Future<void> deleteAccount() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.currentUser!.delete();
        await logout();
      } else {
        throw Exception("user not found");
      }
    } catch (e) {
      throw Exception("Failed to delete account.. error: $e");
    }
  }

  // check google init or not for , jatey bar bar init kora na lagey
  Future<void> initGoogleSignIn() async {
    if (!_isGoogleInitialized) {
      await GoogleSignIn.instance.initialize();
      _isGoogleInitialized = true;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    UserCredential userCredential;
    try {
      // for web
      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        await initGoogleSignIn();
        final GoogleSignInAccount? user = await GoogleSignIn.instance
            .authenticate();

        if (user == null) {
          throw Exception("Google Sign-In cancelled by user.");
        }

        final googleAuth = user.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );
        userCredential = await _auth.signInWithCredential(credential);
      }
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      if (!userDoc.exists) {
        await sendUserData(
          user: UserDataModel(
            name: userCredential.user!.displayName ?? '',
            email: userCredential.user!.email ?? '',
          ),
          id: userCredential.user!.uid,
        );
      }
      return userCredential;
    } catch (e) {
      throw Exception("Google sign-in failed: $e");
    }
  }

  Future<void> googleLogout() async {
    try {
      await GoogleSignIn.instance.disconnect();
      await GoogleSignIn.instance.signOut();
      await _auth.signOut();
    } catch (e) {
      throw Exception("Logout failed.. error : $e");
    }
  }

  //resetlink
  Future<String> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "Resent Link Sended To your Email";
    } catch (e) {
      throw Exception("Password Reset Failed error: $e");
    }
  }

}
