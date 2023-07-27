import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? id;
  String? username;
  String? commentText;
  DateTime? createdAt;
  String? postId;

  CommentModel({
    required this.id,
    required this.username,
    required this.commentText,
    required this.createdAt,
    required this.postId,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      username: json['username'] as String,
      commentText: json['comment_text'] as String,
      postId: json['post_id'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'post_id': postId,
      'comment_text': commentText,
      'created_at': Timestamp.fromDate(createdAt!),
    };
  }
}
