import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:todolist/managers/user_manager.dart';
import 'package:todolist/models/item.dart';
import 'package:todolist/models/user_model.dart';

class CardManager {
  final List<Item> items = [];
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final UserManager userManager = UserManager();
  Future<void> addItem(String content) async {
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc["id"].toString() == userId.trim()) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(doc.id)
              .collection("works")
              .add({"name": content, "date": DateTime.now().toString()}).then(
                  (value) {
            print("add sucess");
            getWorksStream();
          }).catchError(
                  // ignore: invalid_return_type_for_catch_error
                  (error) => print("canot add work : ${error.toString()}"));
        }
      });
    });
  }

  Future<void> deleteCard(String id) async {
    print("id : ${id}");
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc["id"].toString() == userId.trim()) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(doc.id)
              .collection("works")
              .doc(id)
              .delete()
              .then((value) {
            print("delete success");
            getWorksStream();
          }).catchError((error) =>
                  // ignore: invalid_return_type_for_catch_error
                  print("Failed to  delete work : ${error.toString()}"));
        }
      });
    });
  }

  Stream<QuerySnapshot> getWorksStream() async* {
    await for (var querySnapshot in FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: userId)
        .snapshots()) {
      if (querySnapshot.docs.isEmpty) {
        print("Cannot get user");
        // Xử lý logic nếu không tìm thấy user
        yield* Stream<QuerySnapshot>.empty();
      } else {
        DocumentSnapshot doc = querySnapshot.docs.first;
        yield* doc.reference.collection("works").snapshots();
      }
    }
  }
}
