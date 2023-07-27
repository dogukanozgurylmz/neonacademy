import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_task/model/post_model.dart';

class PostService {
  late final CollectionReference<Map<String, dynamic>> _firestore;
  void init() {
    _firestore = FirebaseFirestore.instance.collection('posts');
  }

  Future<List<PostModel>> getAll() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore.orderBy('created_at', descending: true).get();
    List<PostModel> list =
        querySnapshot.docs.map((e) => PostModel.fromJson(e.data())).toList();
    return list;
  }

  Future<List<PostModel>> getByUserId(String userId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .get();
    var list =
        querySnapshot.docs.map((e) => PostModel.fromJson(e.data())).toList();
    return list;
  }

  Future<String> create(PostModel postModel) async {
    String id = _firestore.doc().id;
    postModel.id = id;
    await _firestore.doc(id).set(postModel.toJson());
    return id;
  }

  Future<void> delete(String id) async {
    await _firestore.doc(id).delete();
  }
}
