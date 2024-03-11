import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_team_manager_pro/auth/auth_ops.dart';
import 'package:cricket_team_manager_pro/data_ops/linked_ops/linked_ops_team.dart';
import 'package:cricket_team_manager_pro/data_ops/player_ops.dart';
import 'package:cricket_team_manager_pro/models/player_model.dart';
import 'package:cricket_team_manager_pro/pages/league/leagues_select.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewTeamLeaguesDialogue extends StatefulWidget {
  const ViewTeamLeaguesDialogue({super.key, required this.teamId});

  final String teamId;

  @override
  State<ViewTeamLeaguesDialogue> createState() =>
      _ViewTeamLeaguesDialogueState();
}

class _ViewTeamLeaguesDialogueState extends State<ViewTeamLeaguesDialogue> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Team Leagues"),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.8,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("leagues")
                      .where("teamsIds", arrayContains: widget.teamId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        children: snapshot.data!.docs
                            .map(
                              (doc) => ListTile(
                                title: Text(doc["name"]),
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
            ),
            FutureBuilder(
                future: isTeamCaptian(widget.teamId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LeagueSelectPage(teamId: widget.teamId),
                                ),
                              );
                            },
                            child: const Text("See more leagues."),
                          )
                        : const SizedBox();
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
