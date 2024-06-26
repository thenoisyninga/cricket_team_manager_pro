import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  late String firstName;
  late String lastName;
  late String username;
  late String bio;
  late int age;
  late String gender;
  late double weight;
  late double height;
  late String dpData;
  late List<dynamic> battingSkills;
  late List<dynamic> bowlingSkills;
  late List<dynamic> fieldingSkills;
  late String? teamId;

  Player(
    this.firstName,
    this.lastName,
    this.username,
    this.dpData,
    this.bio,
    this.age,
    this.gender,
    this.weight,
    this.height,
    this.battingSkills,
    this.bowlingSkills,
    this.fieldingSkills,
    this.teamId,
  );

  Player.fromDefault() {
    firstName = "";
    lastName = "";
    username = "";
    bio = "";
    age = 0;
    gender = "";
    dpData = "";
    weight = 0.0;
    height = 0.0;
    battingSkills = [];
    bowlingSkills = [];
    fieldingSkills = [];
    teamId = null;
  }

  Player.fromMap(Map<String, dynamic> map) {
    firstName = map["firstName"];
    lastName = map["lastName"];
    username = map["username"];
    bio = map["bio"];
    age = map["age"];
    gender = map["gender"];
    weight = map["weight"];
    dpData = map["dpData"];
    height = map["height"];
    battingSkills = map["battingSkills"];
    bowlingSkills = map["bowlingSkills"];
    fieldingSkills = map["fieldingSkills"];
    teamId = map["teamId"];
  }

  toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "username": username,
      "bio": bio,
      "age": age,
      "gender": gender,
      "weight": weight,
      "dpData": dpData,
      "height": height,
      "battingSkills": battingSkills,
      "bowlingSkills": bowlingSkills,
      "fieldingSkills": fieldingSkills,
      "teamId": teamId,
    };
  }

  assignTeam(String teamId) {
    this.teamId = teamId;
  }

  bool isBatsmen() {
    if (battingSkills.length < bowlingSkills.length ||
        battingSkills.length < fieldingSkills.length) {
      return false;
    }

    return true;
  }

  bool isBowler() {
    if (bowlingSkills.length < battingSkills.length ||
        bowlingSkills.length < fieldingSkills.length) {
      return false;
    }

    return true;
  }

  bool isFielder() {
    if (fieldingSkills.length < battingSkills.length ||
        fieldingSkills.length < bowlingSkills.length) {
      return false;
    }

    return true;
  }
}
