import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:todolist/models/user_model.dart';

class UserManager {
  Future<UserModel?> getUserData(String userId) async {
    try {
      print("userId: $userId"); // Sử dụng interpolation để rõ ràng hơn
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("id", isEqualTo: userId)
          .get();
      if (querySnapshot.docs.isEmpty) {
        print("No users found with the given ID.");
        return null;
      } else {
        // Chỉ lấy tài liệu đầu tiên từ QuerySnapshot
        DocumentSnapshot doc = querySnapshot.docs.first;
        print(doc.data());
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error getting user data: $e");
      return null;
    }
  }
}
