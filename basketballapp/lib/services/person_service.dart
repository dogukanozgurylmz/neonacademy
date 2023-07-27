import 'package:basketballapp/model/person_model.dart';
import 'package:dio/dio.dart';

class PersonService {
  final dio = Dio();

  Future<List<PersonModel>> getAll() async {
    Response response;
    response = await dio.get("https://dummyapi.io/data/v1/user",
        options: Options(headers: {"app-id": "626444667fd2ba529dea890c"}));
    var data = response.data['data'] as List;
    var list = data.map((e) => PersonModel.fromJson(e)).toList();
    return list;
  }

  Future<String?> create(PersonModel model) async {
    try {
      Response response;
      response =
          await dio.post('https://dummyapi.io/data/v1/user/create', data: {
        'firstName': "asdsad",
        'lastName': "sdfdsf",
        'email': "sdfsff",
      });
      return response.statusMessage;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
