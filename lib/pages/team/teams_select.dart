import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/player_ops.dart';
import 'package:cricket_team_manager_pro/custom_dialogues/add_team.dart';
import 'package:cricket_team_manager_pro/models/player_model.dart';
import 'package:cricket_team_manager_pro/pages/team/team_display.dart';
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
        future: getCurrentPlayerFromFirestore(),
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
                              builder: (context) => const AddTeamDialogue(),
                            ).then((value) {
                              setState(() {});
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
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TeamDisplay(teamId: doc.id),
                                    ),
                                  );
                                },
                                title: Text(
                                  doc.data()["name"],
                                  style: const TextStyle(fontSize: 25),
                                ),
                                subtitle: Text(
                                  "${doc.data()["teamPlayerIds"].length} members",
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
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
