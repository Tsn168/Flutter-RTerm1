import 'package:exam/models/member.dart';

class Task {
  final String title;
  final int durationInHours;
  List<Member> members = [];

  Task({
    required this.title,
    required this.durationInHours,
    required this.members,
  });
}
