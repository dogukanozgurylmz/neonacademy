import 'package:basketballapp/model/person_model.dart';
import 'package:hive/hive.dart';

class UserDatasource {
  Future<void> create(PersonModel person) async {
    try {
      var box = await Hive.openBox<PersonModel>('persons');
      box.add(person);
    } catch (e) {
      print(e);
    }
  }

  Future<void> clear() async {
    try {
      var box = await Hive.openBox<PersonModel>('persons');
      box.clear();
    } catch (e) {
      print(e);
    }
  }

  Future<List<PersonModel>> getBooks() async {
    try {
      var box = await Hive.openBox<PersonModel>('persons');
      return box.values.toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
