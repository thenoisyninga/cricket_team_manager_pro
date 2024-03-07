import 'package:auto_size_text/auto_size_text.dart';
import 'package:cricket_team_manager_pro/data_ops/league_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/player_ops.dart';
import 'package:cricket_team_manager_pro/models/league_model.dart';
import 'package:flutter/material.dart';

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
        if (snapshot.hasData) {
          League league = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: const Text("L E A G U E"),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AutoSizeText(
                    league.name,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Match Timeline
                  const Text("Team Players: "),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView(
                      children: league.matchIds
                          .map((playerID) => FutureBuilder(
                              future: getPlayerFromFirestore(playerID),
                              builder: (context, snapshot) {
                                return ListTile(
                                  title: snapshot.hasData
                                      ? Text(
                                          "${snapshot.data!.firstName} ${snapshot.data!.lastName} ")
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                );
                              }))
                          .toList(),
                    ),
                  ),
                ],
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
