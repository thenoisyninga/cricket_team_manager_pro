import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/models/team_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String?> addTeamToFirestore(Team team) async {
  var db = FirebaseFirestore.instance;

  User? user = await getCurrentUser();

  String? teamID;

  if (user != null) {
    print("adding team");
    var createdDoc = await db.collection("teams").add(team.toMap());

    await createdDoc.get().then(
      (doc) {
        if (doc.data() != null) {
          teamID = doc.id;
        }
      },
    );
  } else {
    print("user null");
  }

  print(teamID);
  return teamID;
}

Future<void> updateTeam(String teamId, Team team) async {
  var db = FirebaseFirestore.instance;

  print("updating team");
  db.collection("teams").doc(teamId).set(team.toMap());
}
