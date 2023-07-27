import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_task/model/comment_model.dart';

class CommentService {
  late final CollectionReference<Map<String, dynamic>> _firestore;
  void init() {
    _firestore = FirebaseFirestore.instance.collection('comments');
  }

  Future<List<CommentModel>> getByPostId(String postId) async {
    var querySnapshot =
        await _firestore.where('post_id', isEqualTo: postId).get();
    var list =
        querySnapshot.docs.map((e) => CommentModel.fromJson(e.data())).toList();
    return list;
  }

  Future<void> create(CommentModel model) async {
    var id = _firestore.doc().id;
    model.id = id;
    await _firestore.doc(id).set(model.toJson());
  }
}
