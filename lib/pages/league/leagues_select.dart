import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/player_ops.dart';
import 'package:cricket_team_manager_pro/dialogues/add_leagues.dart';
import 'package:cricket_team_manager_pro/dialogues/add_team.dart';
import 'package:cricket_team_manager_pro/models/player_model.dart';
import 'package:cricket_team_manager_pro/pages/league/league_display.dart';
import 'package:cricket_team_manager_pro/pages/team/team_display.dart';
import 'package:flutter/material.dart';

class LeagueSelectPage extends StatefulWidget {
  const LeagueSelectPage({super.key, required this.teamId});

  final String teamId;

  @override
  State<LeagueSelectPage> createState() => _LeagueSelectPageState();
}

class _LeagueSelectPageState extends State<LeagueSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("L E A G U E S"),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddLeagueDialogue(
                  teamId: widget.teamId,
                ),
              ).then((value) {
                Navigator.of(context).pop();
              });
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('leagues').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.docs
                    .map(
                      (doc) => ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  LeagueDisplay(leagueId: doc.id),
                            ),
                          );
                        },
                        title: Text(
                          doc.data()["name"],
                          style: const TextStyle(fontSize: 25),
                        ),
                        subtitle: Text(
                          "${doc.data()["teamsIds"].length} teams",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                    )
                    .toList(),
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
