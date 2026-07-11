import 'package:blog_app/models/user_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  //get current user;
  User? get currentUser=> _auth.currentUser;


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

  Future<UserDataModel> fetchUserData(String id) async {
    try {
      final doc = await _firestore.collection('users').doc(id).get();
      if (doc.exists || doc.data() != null) {
        return UserDataModel.fromJson(doc.data()!);
      }
      throw Exception("Data not found...");
    } catch (e) {
      throw Exception("Server error: $e");
    }
  }

  Future<UserCredential> loginByEmailPassword(
   {required String email,
   required String password,}
  ) async {
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
   }
  ) async {
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

  //continue with google

}
