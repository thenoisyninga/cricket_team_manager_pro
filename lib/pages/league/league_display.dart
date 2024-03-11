import 'package:auto_size_text/auto_size_text.dart';
import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/custom_widgets/custom_tiles/match_tile.dart';
import 'package:cricket_team_manager_pro/data_ops/league_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/linked_ops/linked_ops_league.dart';
import 'package:cricket_team_manager_pro/data_ops/match_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/player_ops.dart';
import 'package:cricket_team_manager_pro/custom_dialogues/add_match.dart';
import 'package:cricket_team_manager_pro/data_ops/team_ops.dart';
import 'package:cricket_team_manager_pro/models/league_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LeagueDisplay extends StatefulWidget {
  const LeagueDisplay({super.key, required this.leagueId});

  final String leagueId;

  @override
  State<LeagueDisplay> createState() => _LeagueDisplayState();
}

class _LeagueDisplayState extends State<LeagueDisplay> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLeagueFromFirestore(widget.leagueId),
      builder: ((context, snapshot) {
        if (snapshot.data != null) {
          League league = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text("L E A G U E"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    AutoSizeText(
                      league.name,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),

                    // Match Timeline
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Matches Timeline: "),
                        FutureBuilder(
                            future: getCurrentUser(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.uid ==
                                    league.leagueCreatorId) {
                                  return IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddMatchDialogue(
                                              leagueId: widget.leagueId,
                                            ),
                                          ));
                                    },
                                    icon: const Icon(Icons.add),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            })
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: ListView(
                        children: league.matchIds
                            .map(
                              (matchId) => MatchTile(matchId: matchId),
                            )
                            .toList(),
                      ),
                    ),

                    // Teams in league
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Teams: "),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddMatchDialogue(
                                    leagueId: widget.leagueId,
                                  ),
                                ));
                          },
                          icon: const Icon(Icons.add),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: ListView(
                        children: snapshot.data!.teamsIds.map((teamId) {
                          return FutureBuilder(
                              future: getTeamFromFirestore(teamId),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListTile(
                                    title: Text(
                                      snapshot.data!.name,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    subtitle: Text(
                                      "${snapshot.data!.teamPlayerIds.length} members",
                                      style: TextStyle(color: Colors.grey[400]),
                                    ),
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              });
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
