import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/league_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/player_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/team_ops.dart';
import 'package:cricket_team_manager_pro/models/league_model.dart';
import 'package:cricket_team_manager_pro/models/player_model.dart';
import 'package:cricket_team_manager_pro/models/team_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> createLeague(League league, String teamId) async {
  String? leagueId;

  // register league
  leagueId = await addLeagueToFirestore(league!);
  Team? team = await getTeamFromFirestore(teamId);

  // add league to team's list
  if (leagueId != null && team != null) {
    team.addLeague(leagueId);
    updateTeam(teamId, team);

    // add team to league's list
    League newLeague = (await getLeagueFromFirestore(leagueId))!;
    newLeague.addTeam(teamId);
    updateLeague(leagueId, league);
  }
}

Future<bool> isLeagueCreator(String leagueId) async {
  User? user = await getCurrentUser();
  League? league = await getLeagueFromFirestore(leagueId);

  if (league != null && user != null) {
    return league.leagueCreatorId == user.uid;
  } else {
    return false;
  }
}
