import 'package:flutter/material.dart';

class Passenger {
  final String? name;
  final String? surname;
  final String? team;
  final int? age;
  final String? hometown;
  final String? mail;

  Passenger({
    required this.name,
    required this.surname,
    required this.team,
    required this.age,
    required this.hometown,
    required this.mail,
  });
}

class CustomDataTableView extends StatelessWidget {
  final List<Passenger> passengers = [
    Passenger(
      name: 'Doğukan Özgür',
      surname: 'Yılmaz',
      team: 'Flutter Team',
      age: 23,
      hometown: 'Rize',
      mail: 'dogukan@gmail.com',
    ),
    Passenger(
      name: 'Hasan',
      surname: 'Hüseyin',
      team: 'iOS Team',
      age: 30,
      hometown: 'İstanbul',
      mail: 'hasan@huseyin.com',
    ),
    Passenger(
      name: 'Özgür',
      surname: 'Özgür',
      team: 'Android Team',
      age: 28,
      hometown: 'Ankara',
      mail: 'ozgur@ozgur.com',
    ),
    Passenger(
      name: 'Doğukan',
      surname: 'Doğukan',
      team: 'Design Team',
      age: 32,
      hometown: 'İzmir',
      mail: 'dogukan@dogukan.com',
    ),
  ];
  CustomDataTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataTable'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          showCheckboxColumn: false,
          columns: const <DataColumn>[
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Surname')),
            DataColumn(label: Text('Team')),
            DataColumn(label: Text('Age')),
            DataColumn(label: Text('Home Town')),
            DataColumn(label: Text('Email')),
          ],
          rows: passengers.map((passenger) {
            return DataRow(
              cells: <DataCell>[
                DataCell(Text(passenger.name!)),
                DataCell(Text(passenger.surname!)),
                DataCell(Text(passenger.team!)),
                DataCell(Text(passenger.age.toString())),
                DataCell(Text(passenger.hometown!)),
                DataCell(Text(passenger.mail!)),
              ],
              onSelectChanged: (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PassengerDetailPage(passenger: passenger),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class PassengerDetailPage extends StatelessWidget {
  final Passenger passenger;

  const PassengerDetailPage({required this.passenger});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passenger Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${passenger.name} ${passenger.surname}'),
            Text('Team: ${passenger.team}'),
            Text('Age: ${passenger.age}'),
            Text('Hometown: ${passenger.hometown}'),
            Text('Mail: ${passenger.mail}'),
          ],
        ),
      ),
    );
  }
}
