import 'package:auto_size_text/auto_size_text.dart';
import 'package:cricket_team_manager_pro/data_ops/player_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/team_ops.dart';
import 'package:cricket_team_manager_pro/dialogues/view_team_leagues.dart';
import 'package:cricket_team_manager_pro/models/team_model.dart';
import 'package:flutter/material.dart';

class TeamDisplay extends StatefulWidget {
  const TeamDisplay({super.key, required this.teamId});

  final String teamId;

  @override
  State<TeamDisplay> createState() => _TeasDisplayState();
}

class _TeasDisplayState extends State<TeamDisplay> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTeamFromFirestore(widget.teamId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Team team = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: const Text("T E A M"),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        team.name,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // League
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => ViewTeamLeaguesDialogue(
                                  teamId: widget.teamId,
                                ),
                              );
                            },
                            child: Text(
                              "See Leagues",
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Players List
                      const Text("Team Players: "),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView(
                          children: team.teamPlayerIds
                              .map((playerID) => FutureBuilder(
                                  future: getPlayerFromFirestore(playerID),
                                  builder: (context, snapshot) {
                                    return ListTile(
                                      title: snapshot.hasData
                                          ? Text(
                                              "${snapshot.data!.firstName} ${snapshot.data!.lastName} ")
                                          : const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                    );
                                  }))
                              .toList(),
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      // Bowling LineUp
                      const Text("Bowling lineup: "),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView(
                          children: team.bowlingLineup
                              .map((playerID) => FutureBuilder(
                                  future: getPlayerFromFirestore(playerID),
                                  builder: (context, snapshot) {
                                    return ListTile(
                                      title: snapshot.hasData
                                          ? Text(
                                              "${snapshot.data!.firstName} ${snapshot.data!.lastName} ")
                                          : const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                    );
                                  }))
                              .toList(),
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      // Bowling LineUp
                      const Text("Batting lineup: "),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView(
                          children: team.battingLineup
                              .map((playerID) => FutureBuilder(
                                  future: getPlayerFromFirestore(playerID),
                                  builder: (context, snapshot) {
                                    return ListTile(
                                      title: snapshot.hasData
                                          ? Text(
                                              "${snapshot.data!.firstName} ${snapshot.data!.lastName} ")
                                          : const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                    );
                                  }))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
