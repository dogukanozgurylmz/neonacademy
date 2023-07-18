import 'package:flutter/material.dart';

class CustomSearchView extends StatelessWidget {
  const CustomSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "GeeksForGeeks",
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}

class Person {
  final String name;
  final String surname;

  Person(this.name, this.surname);
}

class CustomSearchDelegate extends SearchDelegate {
  List<Person> people = [
    Person('Mini', 'Mouse'),
    Person('Mickey', 'Mouse'),
    Person('Donald', 'Duck'),
    Person('Goofy', 'Goof'),
    Person('Pluto', 'Dog'),
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Person> matchQuery = [];
    for (var person in people) {
      var fullname = "${person.name} ${person.surname}";
      var result = person.name.toLowerCase().contains(query.toLowerCase()) ||
          person.surname.toLowerCase().contains(query.toLowerCase()) ||
          fullname.toLowerCase().contains(query.toLowerCase());
      if (result) {
        matchQuery.add(person);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result.name),
          subtitle: Text(result.surname),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Person> matchQuery = [];
    for (var person in people) {
      var fullname = "${person.name} ${person.surname}";
      var result = person.name.toLowerCase().contains(query.toLowerCase()) ||
          person.surname.toLowerCase().contains(query.toLowerCase()) ||
          fullname.toLowerCase().contains(query.toLowerCase());
      if (result) {
        matchQuery.add(person);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result.name),
          subtitle: Text(result.surname),
        );
      },
    );
  }
}
