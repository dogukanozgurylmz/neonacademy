import 'package:basketballapp/local_datasource/users_datasource.dart';
import 'package:basketballapp/model/person_model.dart';
import 'package:basketballapp/services/person_service.dart';
import 'package:flutter/material.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  final List<PersonModel> _persons = [];
  final PersonService _personService = PersonService();
  final TextEditingController _firstNameContoller = TextEditingController();
  final TextEditingController _lastNameContoller = TextEditingController();
  final TextEditingController _emailContoller = TextEditingController();
  UserDatasource userDatasource = UserDatasource();
  Future<void> getAllUsers() async {
    var list = await _personService.getAll();
    setState(() {
      _persons.addAll(list);
    });
  }

  Future<void> createUser(PersonModel model) async {
    await _personService.create(model);
  }

  @override
  void initState() {
    super.initState();
    // getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              bool isLoading = false;
              return StatefulBuilder(builder: (context, setState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _firstNameContoller,
                        decoration:
                            const InputDecoration(label: Text("First Name")),
                      ),
                      TextField(
                        controller: _lastNameContoller,
                        decoration:
                            const InputDecoration(label: Text("Last Name")),
                      ),
                      TextField(
                        controller: _emailContoller,
                        decoration:
                            const InputDecoration(label: Text("Email Name")),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          var personModel = PersonModel(
                            id: '',
                            title: _firstNameContoller.text,
                            firstName: _firstNameContoller.text.trim(),
                            lastName: _lastNameContoller.text.trim(),
                            email: _emailContoller.text.trim(),
                            picture: '',
                          );
                          await createUser(personModel);
                          setState(() {
                            _firstNameContoller.clear();
                            _lastNameContoller.clear();
                            _emailContoller.clear();
                            isLoading = true;
                          });
                        },
                        child: const Text("Submit"),
                      ),
                    ],
                  ),
                );
              });
            },
          );
        },
      ),
      body: ListView.builder(
        itemCount: _persons.length,
        itemBuilder: (context, index) {
          var person = _persons[index];
          return ListTile(
            leading: Image.network(
              person.picture!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text("${person.firstName} ${person.lastName}"),
          );
        },
      ),
    );
  }
}
