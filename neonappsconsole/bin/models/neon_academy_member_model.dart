import 'contact_information_model.dart';

class NeonAcademyMemberModel {
  String fullName;
  String title;
  String horoscope;
  String memberLevel;
  String homeTown;
  int age;
  int? motivationLevel;
  ContactInformationModel contactInformationModel;
  Team team;

  NeonAcademyMemberModel({
    required this.fullName,
    required this.title,
    required this.horoscope,
    required this.memberLevel,
    required this.homeTown,
    required this.age,
    required this.contactInformationModel,
    required this.team,
    this.motivationLevel,
  });
}

enum Team {
  flutterDevelopmentTeam,
  iOSDevelopmentTeam,
  androidDevelopmentTeam,
  uIUXDevelopmentTeam,
}
