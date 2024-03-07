import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/player_ops.dart';
import 'package:cricket_team_manager_pro/dialogues/add_team.dart';
import 'package:cricket_team_manager_pro/models/player_model.dart';
import 'package:flutter/material.dart';

class TeamSelectPage extends StatefulWidget {
  const TeamSelectPage({super.key});

  @override
  State<TeamSelectPage> createState() => _TeamSelectPageState();
}

class _TeamSelectPageState extends State<TeamSelectPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPlayerFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Player player = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: const Text("T E A M S"),
                backgroundColor: Colors.transparent,
                actions: [
                  player.teamId != null
                      ? const SizedBox()
                      : IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AddTeamDialogue(),
                            ).then((value) {
                              Navigator.of(context).pop();
                            });
                          },
                          icon: const Icon(Icons.add),
                        )
                ],
              ),
              body: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('teams')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        children: snapshot.data!.docs
                            .map(
                              (doc) => ListTile(
                                title: Text(doc.data()["name"]),
                              ),
                            )
                            .toList(),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
