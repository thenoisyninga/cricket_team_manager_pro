import 'package:cricket_team_manager_pro/models/skillset_model.dart';

class Player {
  late String firstName;
  late String lastName;
  late String username;
  late String bio;
  late int age;
  late String gender;
  late double weight;
  late double height;
  late SkillSet skillSet;

  Player(
    this.firstName,
    this.lastName,
    this.username,
    this.bio,
    this.age,
    this.gender,
    this.weight,
    this.height,
    this.skillSet,
  );
}
