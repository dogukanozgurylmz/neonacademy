import 'package:comedy_club_app/models/ticket_model.dart';

class ActivityModel {
  String? name;
  String? description;
  String? image;
  DateTime? date;
  List<TicketModel>? tickets;

  ActivityModel({
    required this.name,
    required this.description,
    required this.date,
    required this.image,
    required this.tickets,
  });
}
