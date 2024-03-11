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

  return teamID;
}

Future<void> updateTeam(String teamId, Team team) async {
  var db = FirebaseFirestore.instance;

  print("updating team");
  db.collection("teams").doc(teamId).set(team.toMap());
}

Future<Team?> getTeamFromFirestore(String teamId) async {
  var db = FirebaseFirestore.instance;

  Team? team;
  Map<String, dynamic>? teamData;

  await db.collection("teams").doc(teamId).get().then((doc) {
    if (doc.data() != null) {
      teamData = doc.data() as Map<String, dynamic>;
    }
  });

  team = Team.fromMap(teamData!);

  print("Team: " + team.toString());
  return team;
}

Future<bool> playerExistsInTeam(String playerId, String teamId) async {
  Team? team = await getTeamFromFirestore(teamId);

  return team!.joinedLeagueIds.indexWhere((id) => id == playerId) == -1;
}
