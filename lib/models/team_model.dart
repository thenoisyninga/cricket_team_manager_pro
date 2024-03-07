class Team {
  late String captainId;
  late List<String> teamPlayerIds;
  late List<String> battingLineup;
  late List<String> bowlingLineup;
  late String? wicketKeeperId;
  late List<String> joinedLeagueIds;

  Team.fromMap(Map<String, dynamic> map) {
    captainId = map["captainId"];
    teamPlayerIds = map["teamPlayerIds"];
    battingLineup = map["battingLineup"];
    bowlingLineup = map["bowlingLineup"];
    wicketKeeperId = map["wicketKeeperId"];
    joinedLeagueIds = map["joinedLeagueIds"];
  }

  toMap() {
    return {
      "captainId": captainId,
      "teamPlayerIds": teamPlayerIds,
      "battingLineup": battingLineup,
      "bowlingLineup": bowlingLineup,
      "wicketKeeperId": wicketKeeperId,
      "joinedLeagueIds": joinedLeagueIds,
    };
  }

  void addPlayer(String playerID) {
    teamPlayerIds.add(playerID);
    battingLineup.add(playerID);
    bowlingLineup.add(playerID);
  }

  void addLeague(String leagueID) {
    joinedLeagueIds.add(leagueID);
  }
}
