import 'package:auto_size_text/auto_size_text.dart';
import 'package:cricket_team_manager_pro/custom_dialogues/edit_match_dialogue.dart';
import 'package:cricket_team_manager_pro/data_ops/match_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/team_ops.dart';
import 'package:cricket_team_manager_pro/models/match_model.dart';
import 'package:cricket_team_manager_pro/models/team_model.dart';
import 'package:flutter/material.dart';

class MatchDisplay extends StatefulWidget {
  const MatchDisplay({
    super.key,
    required this.matchId,
  });

  @override
  State<MatchDisplay> createState() => _MatchDisplayState();

  final String matchId;
}

class _MatchDisplayState extends State<MatchDisplay> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMatchFromFirestore(widget.matchId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CricketMatch match = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: const Text("M A T C H"),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Team 1
                      FutureBuilder(
                          future: getTeamFromFirestore(match.team1Id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Team team = snapshot.data!;
                              return Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: AutoSizeText(
                                  (team.name),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 40),
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),

                      // Team 2
                      FutureBuilder(
                          future: getTeamFromFirestore(match.team2Id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Team team = snapshot.data!;
                              return Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: AutoSizeText(
                                  (team.name),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 40),
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ],
                  ),

                  // VS
                  const Text(
                    "VS",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 30,
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                              "${match.runsTeam1 ?? "-"} / ${match.numPlayesOutTeam1 ?? "-"}"),
                          Text(
                              "${match.ballsFacedTeam1 == null ? "-" : match.ballsFacedTeam1! ~/ 6}.${match.ballsFacedTeam1 == null ? "-" : match.ballsFacedTeam1! % 6} Overs"),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                              "${match.runsTeam2 ?? "-"} / ${match.numPlayesOutTeam2 ?? "-"}"),
                          Text(
                              "${match.ballsFacedTeam2 == null ? "-" : match.ballsFacedTeam2! ~/ 6}.${match.ballsFacedTeam2 == null ? "-" : match.ballsFacedTeam2! % 6} Overs"),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditMatchDialogue(
                      match: match,
                      matchId: widget.matchId,
                    ),
                  ).then((value) => setState(() {}));
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
