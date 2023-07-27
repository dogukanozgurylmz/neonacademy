import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? username;
  String? email;
  String? photoUrl;
  DateTime? createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.photoUrl,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      photoUrl: json['photo_url'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'photo_url': photoUrl,
      'created_at': Timestamp.fromDate(createdAt!),
    };
  }
}
