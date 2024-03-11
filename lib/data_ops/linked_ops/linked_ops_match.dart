import 'package:cricket_team_manager_pro/data_ops/league_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/match_ops.dart';
import 'package:cricket_team_manager_pro/models/league_model.dart';
import 'package:cricket_team_manager_pro/models/match_model.dart';

Future<void> createMatch(CricketMatch match, String leagueId) async {
  String? matchID;

  // register match
  matchID = await addMatchToFirestore(match);

  League? league = await getLeagueFromFirestore(leagueId);

  // add match to league's list
  if (matchID != null && league != null) {
    league.addMatch(matchID);
    updateLeague(leagueId, league);
  }
}
