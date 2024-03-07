import 'package:cricket_team_manager_pro/data_ops/player_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/team_ops.dart';
import 'package:cricket_team_manager_pro/models/player_model.dart';
import 'package:cricket_team_manager_pro/models/team_model.dart';

Future<void> createTeam(Team team) async {
  String? teamID;

  // register team
  teamID = await addTeamToFirestore(team);
  Player? captain = await getPlayerFromFirestore();

  // add team to captain's list
  if (teamID != null && captain != null) {
    captain.assignTeam(teamID);
    addPlayerToFirestore(captain);
  }
}
