import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? id;
  String? content;
  String? userId;
  String? photoUrl;
  DateTime? createdAt;

  PostModel({
    required this.id,
    required this.content,
    required this.userId,
    required this.photoUrl,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      content: json['content'] as String,
      userId: json['user_id'] as String,
      photoUrl: json['photo_url'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'user_id': userId,
      'photo_url': photoUrl,
      'created_at': Timestamp.fromDate(createdAt!),
    };
  }
}
