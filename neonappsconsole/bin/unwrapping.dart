import 'member_list.dart';
import 'models/neon_academy_member_model.dart';

void unwrapping() {
  List<NeonAcademyMemberModel> members = [];

  members.addAll([
    member1,
    member2,
    member3,
    member4,
    member5,
    member6,
  ]);

  // void increaseMotivation() {
  //   for (var member in members) {
  //     if (member.motivationLevel == null) {
  //       member.motivationLevel = 1;
  //     } else {
  //       member.motivationLevel = member.motivationLevel! + 1;
  //     }
  //   }
  // }

  // for (var member in members) {
  //   if (member.motivationLevel == null) {
  //     print("This member has no motivation level set");
  //   } else if (member.motivationLevel! > 5) {
  //     print("This member is highly motivated");
  //   }
  // }

  // for (var member in members) {
  //   if (member.motivationLevel != null) {
  //     print("${member.fullName} motivation: ${member.motivationLevel}");
  //   } else {
  //     print("${member.fullName} motivation: 0");
  //   }
  // }

  void increaseMotivation(NeonAcademyMemberModel member, [int increaseBy = 1]) {
    if (member.motivationLevel == null) {
      member.motivationLevel = 1;
    } else {
      member.motivationLevel = member.motivationLevel! + increaseBy;
    }
  }

  String getMotivationMessage(NeonAcademyMemberModel member) {
    if (member.motivationLevel == null) {
      return "This member has no motivation level set";
    } else if (member.motivationLevel! > 5) {
      return "This member is highly motivated";
    } else {
      return "This member's motivation level is within the normal range";
    }
  }

  String getMotivationStatus(NeonAcademyMemberModel member) {
    if (member.motivationLevel == null) {
      return "No motivation level set";
    } else if (member.motivationLevel! > 5) {
      return "Highly motivated";
    } else if (member.motivationLevel! > 2) {
      return "Moderately motivated";
    } else {
      return "Not motivated";
    }
  }

  int getMemberMotivationLevel(NeonAcademyMemberModel member) {
    return member.motivationLevel ?? 0;
  }

  bool isMemberMotivatedByTargetLevel(
      NeonAcademyMemberModel member, int targetLevel) {
    return member.motivationLevel != null &&
        member.motivationLevel! >= targetLevel;
  }

  increaseMotivation(member5, 3);
  print(getMotivationMessage(member2));
  print(getMotivationStatus(member2));
  print(getMemberMotivationLevel(member2));
  print(isMemberMotivatedByTargetLevel(member2, 5));
}
