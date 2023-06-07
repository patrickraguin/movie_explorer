import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/profile.dart';

class UserRepository {
  UserRepository(this.firebaseAuth, this.firestore);

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  Future<bool> init() async {
    return firebaseAuth.currentUser != null;
  }

  Future<void> login(String username, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(email: username, password: password);
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  Future<void> rate(int movieId, double rating) async {
    await firestore.doc('users/${firebaseAuth.currentUser?.uid}/movies/${movieId.toString()}').set({'rating': rating});
  }

  Future<void> updateProfile(Profile profile) async {
    await firestore
        .doc('users/${firebaseAuth.currentUser?.uid}')
        .set({'firstname': profile.firstname, 'lastname': profile.lastname});
  }

  Future<Profile> fetchProfile() async {
    final doc = await firestore.doc('users/${firebaseAuth.currentUser?.uid}').get();
    final Map<String, dynamic> data = doc.data() ?? {};
    return Profile(data['firstname'] ?? '', data['lastname'] ?? '');
  }
}
