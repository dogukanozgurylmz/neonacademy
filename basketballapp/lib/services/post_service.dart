import 'package:dio/dio.dart';

import '../model/post_model.dart';

class PostService {
  final dio = Dio();

  Future<List<PostModel>> getAll() async {
    Response response;
    response = await dio.get("https://jsonplaceholder.typicode.com/posts");
    var data = response.data as List;
    var list = data.map((e) => PostModel.fromJson(e)).toList();
    return list;
  }

  Future<String?> create(PostModel model) async {
    try {
      Response response;
      response = await dio.post('https://jsonplaceholder.typicode.com/posts',
          data: model.toJson());
      return response.statusMessage;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
