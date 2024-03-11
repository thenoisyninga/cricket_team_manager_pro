import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/player_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/team_ops.dart';
import 'package:cricket_team_manager_pro/models/player_model.dart';
import 'package:cricket_team_manager_pro/models/team_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> createTeam(Team team) async {
  String? teamID;
  User? user = await getCurrentUser();

  team.addPlayer(user!.uid);

  // register team
  teamID = await addTeamToFirestore(team);
  Player? captain = await getCurrentPlayerFromFirestore();

  // add team to captain's list
  if (teamID != null && captain != null) {
    captain.assignTeam(teamID);
    addPlayerToFirestore(captain);

    // add captain to team
  }
}

Future<bool> isTeamCaptian(String teamId) async {
  User? user = await getCurrentUser();
  Team? team = await getTeamFromFirestore(teamId);

  if (team != null && user != null) {
    return team.captainId == user.uid;
  } else {
    return false;
  }
}

Future<void> addPlayerToTeam(String playerId, String teamId) async {
  Player? player = await getPlayerFromFirestore(playerId);
  Team? team = await getTeamFromFirestore(teamId);

  if (!(await (playerExistsInTeam(playerId, teamId)))) {
    print("adding player to team");

    // add team to player object
    player?.assignTeam(teamId);
    addPlayerToFirestore(player!);

    // add player to team and update
    team!.addPlayer(playerId);
    updateTeam(teamId, team);
  } else {
    print("already exists");
  }
}
