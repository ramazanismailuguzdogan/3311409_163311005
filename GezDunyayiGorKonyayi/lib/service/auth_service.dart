import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //giriş yap fonksiyonu
  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  //çıkış yap fonksiyonu
  signOut() async {
    return await _auth.signOut();
  }

  //kayıt ol fonksiyonu
  Future<User?> createPerson(String userName, String email, String password,
      String profileImage, String createDate) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore.collection("Person").doc(user.user!.uid).set({
      'userName': userName,
      'password': password,
      'email': email,
      'profileImage': profileImage,
      'createDate': createDate
    });

    return user.user;
  }

  //kayıt güncelleme fonksiyonu
  Future<User?> updatePerson(
      String userName,
      String email,
      String currentPassword,
      String newPassword,
      String profileImage,
      String createDate) async {
    var user = await _auth.currentUser!;
    var credential = await EmailAuthProvider.credential(
        email: user.email!, password: currentPassword);

    user.reauthenticateWithCredential(credential).then((value) {
      user.updatePassword(newPassword);
    });

    await _firestore.collection("Person").doc(user.uid).set({
      'userName': userName,
      'password': newPassword,
      'email': email,
      'profileImage': profileImage,
      'createDate': createDate
    });

    return user;
  }

//kayıt çekme fonksiyonu
  Future<DocumentSnapshot?> getPerson() async {
    var user = await _auth.currentUser!;
    var snapshot = await _firestore.collection("Person").doc(user.uid).get();
    return snapshot;
  }
}
