class PersonModel {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? email;
  String? picture;

  PersonModel({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.picture,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      title: json["title"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      picture: json["picture"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'picture': picture,
    };
  }
}
