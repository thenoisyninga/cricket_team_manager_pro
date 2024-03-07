class Team {
  late String name;
  late String captainId;
  List<String> teamPlayerIds = [];
  List<String> battingLineup = [];
  List<String> bowlingLineup = [];
  String? wicketKeeperId;
  List<String> joinedLeagueIds = [];

  Team(
    this.name,
    this.captainId,
  );

  Team.fromMap(Map<String, dynamic> map) {
    name = map["name"];
    captainId = map["captainId"];
    teamPlayerIds = map["teamPlayerIds"];
    battingLineup = map["battingLineup"];
    bowlingLineup = map["bowlingLineup"];
    wicketKeeperId = map["wicketKeeperId"];
    joinedLeagueIds = map["joinedLeagueIds"];
  }

  toMap() {
    return {
      "name": name,
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
