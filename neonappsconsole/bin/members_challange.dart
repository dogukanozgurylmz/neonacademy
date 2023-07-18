import 'dart:io';

import 'member_list.dart';
import 'models/contact_information_model.dart';
import 'models/neon_academy_member_model.dart';

void membersChallange() {
  List<NeonAcademyMemberModel> members = [];
  List<NeonAcademyMemberModel> olderThan24Members = [];

  members.addAll([
    member1,
    member2,
    member3,
    member4,
    member5,
    member6,
  ]);
  //Delete the 3rd member.
  print("Delete the 3rd member. ***********");
  members.removeAt(2);
  members.forEach((element) => print(element.fullName));

  //Rank the members according to their age from largest to smallest.
  print(
      "Rank the members according to their age from largest to smallest. ***********");
  members.sort((a, b) => a.age.compareTo(b.age));
  members.forEach((element) => print("${element.fullName} ${element.age}"));

  //Sort the members according to their names (Z-A).
  print("Sort the members according to their names (Z-A). ***********");
  members.sort((a, b) => a.fullName.compareTo(b.fullName));
  members.forEach(
      (element) => print(element.fullName + " " + element.age.toString()));

  //Filter the members of the Academy who are older than 24 and transfer them to a new array.
  print(
      "Filter the members of the Academy who are older than 24 and transfer them to a new array. ***********");
  for (var member in members) {
    if (member.age > 24) {
      olderThan24Members.add(member);
    }
  }
  olderThan24Members
      .forEach((element) => print("${element.fullName} ${element.age}"));

  //Print the total number of Flutter Developers.
  print("Print the total number of Flutter Developers. ***********");
  int total = 0;
  for (var member in members) {
    if (member.title == "Flutter Developer") {
      total = total + 1;
    }
  }
  print(total);

  //Find which index you come across in the array and print it.
  print(
      "Find which index you come across in the array and print it. ***********");
  var indexWhere = members
      .indexWhere((element) => element.fullName == "Doğukan Özgür Yılmaz");
  print(indexWhere);

  //Add a new member to the array, who is a mentor of the academy and has a special property "mentorLevel" indicating their level of experience.
  //Print out the full names of all members after adding the new member.
  print("mentorLevel ***********");
  NeonAcademyMemberModel mentorLevel = NeonAcademyMemberModel(
    fullName: "Mehmet",
    title: "Co-Founder",
    horoscope: "Oğlak",
    memberLevel: "mentorLevel",
    homeTown: "Artvin",
    age: 33,
    contactInformationModel: ContactInformationModel(
      phoneNumber: "01111111111",
      email: "mehmet@gmail.com",
    ),
    team: Team.iOSDevelopmentTeam,
  );
  members.add(mentorLevel);
  members.forEach((element) => print(element.fullName));

  //Remove all members who have a specific memberLevel, for example, "A1", and print out the remaining members' full names.
  print(
      "Remove all members who have a specific memberLevel, for example, 'A1', and print out the remaining members' full names. ***********");
  for (var member in List.from(members)) {
    if (member.memberLevel == "B1") {
      members.remove(member);
    }
    print(member.fullName);
  }

  //Find the member with the highest age and print out their full name and age.
  print(
      "Find the member with the highest age and print out their full name and age. ***********");
  members.sort((a, b) => a.age.compareTo(b.age));
  print("${members.last.fullName} ${members.last.age}");

  //Find the member with the longest name and print out their full name and the length of their name.
  print(
      "Find the member with the longest name and print out their full name and the length of their name. ***********");
  members.sort((a, b) => a.fullName.length.compareTo(b.fullName.length));
  print("${members.last.fullName} ${members.last.fullName.length}");

  //Find all members who have the same horoscope sign and group them together in a new array. Print out the full names of members in this new array.
  print(
      "Find all members who have the same horoscope sign and group them together in a new array. ***********");
  final List<NeonAcademyMemberModel> horoscopeVirgo = [];
  final List<NeonAcademyMemberModel> horoscopeLeo = [];
  final List<NeonAcademyMemberModel> horoscopeAries = [];
  final List<NeonAcademyMemberModel> horoscopeCapricorn = [];
  for (var member in members) {
    if (member.horoscope == "Başak") {
      horoscopeVirgo.add(member);
    } else if (member.horoscope == "Aslan") {
      horoscopeLeo.add(member);
    } else if (member.horoscope == "Oğlak") {
      horoscopeCapricorn.add(member);
    } else if (member.horoscope == "Koç") {
      horoscopeAries.add(member);
    }
  }
  horoscopeVirgo
      .forEach((element) => print("${element.fullName} ${element.horoscope}"));
  horoscopeLeo
      .forEach((element) => print("${element.fullName} ${element.horoscope}"));
  horoscopeAries
      .forEach((element) => print("${element.fullName} ${element.horoscope}"));
  horoscopeCapricorn
      .forEach((element) => print("${element.fullName} ${element.horoscope}"));

  //Find the most common hometown among the members and print out the name of the town.
  print(
      "Find the most common hometown among the members and print out the name of the town. ***********");
  Map<String, List<NeonAcademyMemberModel>> cities = {};
  for (var member in members) {
    if (!cities.containsKey(member.homeTown)) {
      cities[member.homeTown] = [];
    }
    cities[member.homeTown]!.add(member);
  }
  int maxCount = 0;
  String moreCity = "";
  for (var entry in cities.entries) {
    if (entry.value.length > maxCount) {
      print(entry.key);
      moreCity = entry.key;
    }
  }
  print("City: $moreCity");

  //Find the average age of all members and print out the result.
  print(
      "Find the average age of all members and print out the result. ***********");
  int totalAge = 0;
  for (var member in members) {
    totalAge = totalAge + member.age;
  }
  var result = totalAge / members.length;
  print("average age $result");

  //Create a new array that contains only the contact information of the members, and print out the email addresses of all members in this new array.
  print(
      "Create a new array that contains only the contact information of the members, and print out the email addresses of all members in this new array. ***********");
  List<String> newList = [];
  for (var member in members) {
    newList.add(member.contactInformationModel.email);
  }
  print(newList);

  //Sort the members according to their memberLevel (highest to lowest) and print out their full names.
  print(
      "Sort the members according to their memberLevel (highest to lowest) and print out their full names. ***********");
  List<NeonAcademyMemberModel> newMemberList = [];
  members.sort(
    (a, b) => b.memberLevel.compareTo(a.memberLevel),
  );
  print(members);
  for (var member in members) {
    if (member.memberLevel == "mentorLevel") {
      newMemberList.insert(0, member);
    } else {
      newMemberList.add(member);
    }
  }
  for (var member in newMemberList) {
    print(member.fullName);
  }

  //Find all members who have the same title and create a new array of their contact information, then print out the phone numbers of all members in this new array.
  print(
      "Find all members who have the same title and create a new array of their contact information, then print out the phone numbers of all members in this new array. ***********");
  List<String> phoneNumber = [];
  for (var member in members) {
    phoneNumber.add(member.contactInformationModel.phoneNumber);
  }
  print(phoneNumber);

  //Enums, Switch

  //Create a new array that contains only the members of the Flutter Development Team and print out their full names.
  print(
      "Create a new array that contains only the members of the Flutter Development Team and print out their full names. ***********");
  List<NeonAcademyMemberModel> newFlutterMemberList = [];
  for (var member in members) {
    switch (member.team) {
      case Team.flutterDevelopmentTeam:
        newFlutterMemberList.add(member);
        break;
      default:
    }
  }
  print(newFlutterMemberList);

  //Create a dictionary that contains the number of members in each team, and print out the number of members in the UI/UX Design Team.
  print(
      "Create a dictionary that contains the number of members in each team, and print out the number of members in the UI/UX Design Team. ***********");
  Map<Team, int> teamMemberCountMap = {};
  for (var member in members) {
    if (!teamMemberCountMap.containsKey(member.team)) {
      teamMemberCountMap[member.team] = 1;
    } else {
      teamMemberCountMap[member.team] =
          (teamMemberCountMap[member.team] ?? 0) + 1;
    }
  }
  var uiuxCount = teamMemberCountMap[Team.uIUXDevelopmentTeam];
  print("UI-UX Development Team Count: $uiuxCount");

  //Create a function that takes a team as an input and prints out the full names of all members in that team.
  print(
      "Create a function that takes a team as an input and prints out the full names of all members in that team. ***********");
  print("A) ${Team.androidDevelopmentTeam}");
  print("B) ${Team.flutterDevelopmentTeam}");
  print("C) ${Team.iOSDevelopmentTeam}");
  print("D) ${Team.uIUXDevelopmentTeam}");
  String? result1 = stdin.readLineSync();

  switch (result1) {
    case "A":
      for (var member in members) {
        if (member.team == Team.androidDevelopmentTeam) {
          print(member.fullName);
        }
      }
      break;
    case "B":
      for (var member in members) {
        if (member.team == Team.flutterDevelopmentTeam) {
          print(member.fullName);
        }
      }
      break;
    case "C":
      for (var member in members) {
        if (member.team == Team.iOSDevelopmentTeam) {
          print(member.fullName);
        }
      }
      break;
    case "D":
      for (var member in members) {
        if (member.team == Team.uIUXDevelopmentTeam) {
          print(member.fullName);
        }
      }
      break;
    default:
  }

  //Create a switch statement that performs different actions based on the team of a member. For example, if a member is in the Flutter Development Team, the function could print out "This member is a skilled Flutter developer", and if the member is in the UI/UX Design Team, the function could print out "This member is a talented designer".
  print(
      "Create a switch statement that performs different actions based on the team of a member. ***********");
  for (var member in members) {
    switch (member.team) {
      case Team.androidDevelopmentTeam:
        print("${member.fullName}: This member is a skilled Android developer");
        break;
      case Team.flutterDevelopmentTeam:
        print("${member.fullName}: This member is a skilled Flutter developer");
        break;
      case Team.iOSDevelopmentTeam:
        print("${member.fullName}: This member is a skilled iOS developer");
        break;
      case Team.uIUXDevelopmentTeam:
        print("${member.fullName}: This member is a talented designer");
        break;
      default:
    }
  }
  //Create a function that takes an age as an input and prints out the full names of all members that are older than that age and belong to a specific team (Flutter Development Team for example)
  print(
      "Create a function that takes an age as an input and prints out the full names of all members that are older than that age and belong to a specific team (Flutter Development Team for example) ***********");
  print("Input age");
  String? result2 = stdin.readLineSync();
  List<NeonAcademyMemberModel> flutterTeam = [];
  List<NeonAcademyMemberModel> androidTeam = [];
  List<NeonAcademyMemberModel> iosTeam = [];
  List<NeonAcademyMemberModel> uiuxTeam = [];

  for (var member in members) {
    if (member.age > int.parse(result2!)) {
      switch (member.team) {
        case Team.flutterDevelopmentTeam:
          flutterTeam.add(member);
          break;
        case Team.androidDevelopmentTeam:
          androidTeam.add(member);
          break;
        case Team.iOSDevelopmentTeam:
          iosTeam.add(member);
          break;
        case Team.uIUXDevelopmentTeam:
          uiuxTeam.add(member);
          break;
        default:
      }
    }
  }
  flutterTeam.isEmpty ? print("") : print("Flutter Team:");
  for (var flutterTeam in flutterTeam) {
    print(flutterTeam.fullName);
  }
  androidTeam.isEmpty ? print("") : print("Android Team:");
  for (var androidTeam in androidTeam) {
    print(androidTeam.fullName);
  }
  iosTeam.isEmpty ? print("") : print("iOS Team:");
  for (var iosTeam in iosTeam) {
    print(iosTeam.fullName);
  }
  uiuxTeam.isEmpty ? print("") : print("UI IX Team:");
  for (var uiuxTeam in uiuxTeam) {
    print(uiuxTeam.fullName);
  }

  //Create a switch statement that gives a promotion to a member based on their team. For example, if a member is in the Flutter Development Team, the function could promote them to "Senior Flutter Developer" and if the member is in the UI/UX Design Team, the function could promote them to "Lead Designer".
  print(
      "Create a switch statement that gives a promotion to a member based on their team.  ***********");

  void promoteMember(NeonAcademyMemberModel member) {
    switch (member.team) {
      case Team.flutterDevelopmentTeam:
        member.title = "Senior Flutter Developer";
        break;
      case Team.androidDevelopmentTeam:
        member.title = "Senior Android Developer";
        break;
      case Team.iOSDevelopmentTeam:
        member.title = "Senior iOS Developer";
        break;
      case Team.uIUXDevelopmentTeam:
        member.title = "Lead Designer";
        break;
      default:
        print("Geçersiz takım!");
    }
  }

  for (var member in members) {
    print("${member.fullName} Önceki pozisyon: ${member.title}");
    promoteMember(member);
    print("${member.fullName} Yeni pozisyon: ${member.title}");
  }

  //Create a function that takes a team as an input and calculates the average age of the members in that team.
  print(
      "Create a function that takes a team as an input and calculates the average age of the members in that team.  ***********");
  print("A) ${Team.androidDevelopmentTeam}");
  print("B) ${Team.flutterDevelopmentTeam}");
  print("C) ${Team.iOSDevelopmentTeam}");
  print("D) ${Team.uIUXDevelopmentTeam}");
  String? result3 = stdin.readLineSync();
  int total2 = 0;

  List<NeonAcademyMemberModel> flutterTeam2 = [];
  List<NeonAcademyMemberModel> androidTeam2 = [];
  List<NeonAcademyMemberModel> iosTeam2 = [];
  List<NeonAcademyMemberModel> uiuxTeam2 = [];
  switch (result1) {
    case "A":
      for (var member in members) {
        if (member.team == Team.androidDevelopmentTeam) {
          androidTeam2.add(member);
          total2 = total2 + member.age;
        }
      }
      print(total2 / androidTeam2.length);
      break;
    case "B":
      for (var member in members) {
        if (member.team == Team.flutterDevelopmentTeam) {
          flutterTeam2.add(member);
          total2 = total2 + member.age;
        }
      }
      print(total2 / flutterTeam2.length);
      break;
    case "C":
      for (var member in members) {
        if (member.team == Team.iOSDevelopmentTeam) {
          iosTeam2.add(member);
          total2 = total2 + member.age;
        }
      }
      print(total2 / iosTeam2.length);
      break;
    case "D":
      for (var member in members) {
        if (member.team == Team.uIUXDevelopmentTeam) {
          uiuxTeam2.add(member);
          total2 = total2 + member.age;
        }
      }
      print(total2 / uiuxTeam2.length);
      break;
    default:
  }

  //Create a switch statement that prints out a different message for each team, such as "The Flutter Development Team is the backbone of our academy" for the Flutter Development Team and "The UI/UX Design Team is the face of our academy" for the UI/UX Design Team.
  print(
      "Create a switch statement that prints out a different message for each team, such as 'The Flutter Development Team is the backbone of our academy' for the Flutter Development Team and 'The UI/UX Design Team is the face of our academy' for the UI/UX Design Team.  ***********");
  for (var member in members) {
    switch (member.team) {
      case Team.flutterDevelopmentTeam:
        print("The Flutter Development Team is the backbone of our academy");
        break;
      case Team.androidDevelopmentTeam:
        print("The Android Development Team is the backbone of our academy");
        break;
      case Team.iOSDevelopmentTeam:
        print("The iOS Development Team is the backbone of our academy");
        break;
      case Team.uIUXDevelopmentTeam:
        print("The UI/UX Design Team is the face of our academy");
        break;
      default:
        print("Geçersiz takım!");
    }
  }

  //Create a function that takes a team as an input and returns an array of the contact information of all members in that team.
  print(
      "Create a function that takes a team as an input and returns an array of the contact information of all members in that team. ***********");
  print("A) ${Team.androidDevelopmentTeam}");
  print("B) ${Team.flutterDevelopmentTeam}");
  print("C) ${Team.iOSDevelopmentTeam}");
  print("D) ${Team.uIUXDevelopmentTeam}");

  List<ContactInformationModel> flutterTeamContact = [];
  List<ContactInformationModel> androidTeamContact = [];
  List<ContactInformationModel> iosTeamContact = [];
  List<ContactInformationModel> uiuxTeamContact = [];
  switch (result1) {
    case "A":
      for (var member in members) {
        if (member.team == Team.androidDevelopmentTeam) {
          androidTeamContact.add(member.contactInformationModel);
        }
      }
      androidTeamContact.forEach(
          (element) => print("${element.email} ${element.phoneNumber}"));
      break;
    case "B":
      for (var member in members) {
        if (member.team == Team.flutterDevelopmentTeam) {
          flutterTeamContact.add(member.contactInformationModel);
        }
      }
      flutterTeamContact.forEach(
          (element) => print("${element.email} ${element.phoneNumber}"));
      break;
    case "C":
      for (var member in members) {
        if (member.team == Team.iOSDevelopmentTeam) {
          iosTeamContact.add(member.contactInformationModel);
        }
      }
      iosTeamContact.forEach(
          (element) => print("${element.email} ${element.phoneNumber}"));
      break;
    case "D":
      for (var member in members) {
        if (member.team == Team.uIUXDevelopmentTeam) {
          uiuxTeamContact.add(member.contactInformationModel);
        }
      }
      uiuxTeamContact.forEach(
          (element) => print("${element.email} ${element.phoneNumber}"));
      break;
    default:
  }

  //Create a switch statement that performs different actions based on the team of a member and their age. For example, if a member is in the Flutter Development Team and is over 23 years old, the function could print out "XXX member is a seasoned Flutter developer", and if the member is in the UI/UX Design Team and is under 24, the function could print out "XXX member is a rising star in the design world".
  print(
      "Create a switch statement that performs different actions based on the team of a member and their age. ***********");
  for (var member in members) {
    switch (member.team) {
      case Team.flutterDevelopmentTeam:
        if (member.age > 23) {
          print("${member.fullName} member is a seasoned Flutter developer");
        }
        break;
      case Team.androidDevelopmentTeam:
        if (member.age > 23) {
          print("${member.fullName} member is a seasoned Android developer");
        }
        break;
      case Team.iOSDevelopmentTeam:
        if (member.age > 23) {
          print("${member.fullName} member is a seasoned iOS developer");
        }
        break;
      case Team.uIUXDevelopmentTeam:
        if (member.age < 24) {
          print(
              "${member.fullName} member is a rising star in the design world");
        }
        break;
      default:
    }
  }
}
