class League {
  late String name;
  late String leagueCreatorId;
  late List<dynamic> teamsIds;
  late List<dynamic> matchIds;
  late dynamic startDay;
  late dynamic endDay;

  League(
    this.name,
    this.teamsIds,
    this.matchIds,
    this.startDay,
    this.endDay,
  );

  League.fromDefault(this.name) {
    teamsIds = [];
    matchIds = [];
    startDay = null;
    endDay = null;
  }

  League.fromMap(Map<String, dynamic> map) {
    name = map["name"];
    leagueCreatorId = map["leagueCreatorId"];
    teamsIds = map["teamsIds"];
    matchIds = map["matchIds"];
    startDay = map["startDay"];
    endDay = map["endDay"];
  }

  toMap() {
    return {
      "name": name,
      "teamsIds": teamsIds,
      "matchIds": matchIds,
      "startDay": startDay,
      "leagueCreatorId": leagueCreatorId,
      "endDay": endDay,
    };
  }

  void addMatch(String matchId) {
    matchIds.add(matchId);
  }

  void addTeam(String teamId) {
    teamsIds.add(teamId);
  }
}
