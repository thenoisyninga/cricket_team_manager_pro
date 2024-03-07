class League {
  late String leagueId;
  late String name;
  late List<String> teamsIds;
  late List<String> matchIds;
  late DateTime? startDay;
  late DateTime? endDay;

  League(
    this.leagueId,
    this.name,
    this.teamsIds,
    this.matchIds,
    this.startDay,
    this.endDay,
  );

  League.fromMap(Map<String, dynamic> map) {
    leagueId = map["leagueId"];
    name = map["name"];
    teamsIds = map["teamsIds"];
    matchIds = map["matchIds"];
    startDay = map["startDay"];
    endDay = map["endDay"];
  }

  toMap() {
    return {
      "leagueId": leagueId,
      "name": name,
      "teamsIds": teamsIds,
      "matchIds": matchIds,
      "startDay": startDay,
      "endDay": endDay,
    };
  }
}
