import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class UserManager {
  Future<void> getUserData(String userId) async {
    print("userId : " + userId);
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    if (snapshot.exists) {
      print("Document data: ${snapshot.data()}");
    } else {
      print("No such document!");
    }
  }
}
