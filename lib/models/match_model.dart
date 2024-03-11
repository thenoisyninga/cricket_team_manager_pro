class CricketMatch {
  late String leagueId;
  late String team1Id;
  late String team2Id;
  late dynamic dayOfMatch;
  late int? ballsFacedTeam1;
  late int? ballsFacedTeam2;
  late int? runsTeam1;
  late int? runsTeam2;
  late int? numPlayesOutTeam1;
  late int? numPlayesOutTeam2;

  CricketMatch(
    this.leagueId,
    this.team1Id,
    this.team2Id,
    this.dayOfMatch,
    this.ballsFacedTeam1,
    this.ballsFacedTeam2,
    this.runsTeam1,
    this.runsTeam2,
    this.numPlayesOutTeam1,
    this.numPlayesOutTeam2,
  );

  CricketMatch.fromMap(Map<String, dynamic> map) {
    leagueId = map["leagueId"];
    team1Id = map["team1Id"];
    team2Id = map["team2Id"];
    dayOfMatch = map["dayOfMatch"];
    ballsFacedTeam1 = map["ballsFacedTeam1"];
    ballsFacedTeam2 = map["ballsFacedTeam2"];
    runsTeam1 = map["runsTeam1"];
    runsTeam2 = map["runsTeam2"];
    numPlayesOutTeam1 = map["numPlayesOutTeam1"];
    numPlayesOutTeam2 = map["numPlayesOutTeam2"];
  }

  Map<String, dynamic> toMap() {
    return {
      "leagueId": leagueId,
      "team1Id": team1Id,
      "team2Id": team2Id,
      "dayOfMatch": dayOfMatch,
      "ballsFacedTeam1": ballsFacedTeam1,
      "ballsFacedTeam2": ballsFacedTeam2,
      "runsTeam1": runsTeam1,
      "runsTeam2": runsTeam2,
      "numPlayesOutTeam1": numPlayesOutTeam1,
      "numPlayesOutTeam2": numPlayesOutTeam2,
    };
  }
}
