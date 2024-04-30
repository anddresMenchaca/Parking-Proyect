import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> auntenticator(var user, var password) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: user, password: password);
    return credential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
    } else if (e.code == 'wrong-password') {}
    return null; // Devuelve null en caso de error.
  }
}

Stream<QuerySnapshot> getParkingsByOwner(String ownerId) {
  return FirebaseFirestore.instance
      .collection('parqueo')
      .where('idDuenio', isEqualTo: ownerId)
      .snapshots();
}

Stream<QuerySnapshot> getAllParkings() {
  return FirebaseFirestore.instance.collection('parqueo').snapshots();
}