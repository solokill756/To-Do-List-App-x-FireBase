// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String email;
  String firstName;
  String lastName;
  int age;
  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      age: map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
