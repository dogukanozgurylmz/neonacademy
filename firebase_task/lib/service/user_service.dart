import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_task/model/user_model.dart';

class UserService {
  late final CollectionReference<Map<String, dynamic>> _firestore;
  void init() {
    _firestore = FirebaseFirestore.instance.collection('users');
  }

  Future<List<UserModel>> getAll() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore.get();
    List<UserModel> list =
        querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
    return list;
  }

  Future<void> create(UserModel userModel) async {
    await _firestore.add(userModel.toJson());
  }

  Future<void> delete(String id) async {
    await _firestore.doc(id).delete();
  }

  Future<void> update(UserModel userModel) async {
    QuerySnapshot querySnapshot =
        await _firestore.where('id', isEqualTo: userModel.id).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      await documentSnapshot.reference.update(userModel.toJson());
    }
  }

  Future<UserModel> getById(String id) async {
    var querySnapshot = await _firestore.where('id', isEqualTo: id).get();
    return UserModel.fromJson(querySnapshot.docs.first.data());
  }
}
